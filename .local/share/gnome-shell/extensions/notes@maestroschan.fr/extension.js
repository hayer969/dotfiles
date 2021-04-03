// notes@maestroschan.fr/extension.js
// GPL v3
// Copyright 2018-2021 Romain F. T.

const { St, Shell, GLib, Gio, Meta } = imports.gi;
const PanelMenu = imports.ui.panelMenu;
const Panel = imports.ui.panel;
const Main = imports.ui.main;
const Mainloop = imports.mainloop;

// Retrocompatibility
const ShellVersion = imports.misc.config.PACKAGE_VERSION;
var USE_ACTORS = parseInt(ShellVersion.split('.')[1]) < 33;

const ExtensionUtils = imports.misc.extensionUtils;
const Me = ExtensionUtils.getCurrentExtension();
const Convenience = Me.imports.convenience;

const NoteBox = Me.imports.noteBox;

const Gettext = imports.gettext.domain('notes-extension');
const _ = Gettext.gettext;

//------------------------------------------------------------------------------

const PATH = GLib.build_pathv('/', [GLib.get_user_data_dir(), 'notes@maestroschan.fr']);
// which is usually ~/.local/share/notes@maestroschan.fr

var NOTES_MANAGER;
var SETTINGS;
var Z_POSITION;
var AUTO_FOCUS;

function init() {
	Convenience.initTranslations();
	try {
		let a = Gio.file_new_for_path(PATH);
		if (!a.query_exists(null)) {
			a.make_directory(null);
		}
	} catch (e) {
		log(e.message);
	}
	Z_POSITION = '';
}

function enable() {
	SETTINGS = Convenience.getSettings();
	AUTO_FOCUS = SETTINGS.get_boolean('auto-focus'); // XXX crado

	NOTES_MANAGER = new NotesManager();
}

function disable() {
	NOTES_MANAGER.destroy();
}

//------------------------------------------------------------------------------

/*
 * A singleton that manages the button in the top bar, and thus provides the
 * actions of loading, showing, hiding, creating (and in some way saving and
 * destroying) all the notes.
 * If no note exists, it will create the first one itself, otherwise it serves
 * as a middleman between the note whose "new" button has been pressed and the
 * new one.
 */
class NotesManager {
	constructor() {
		// Initialisation of the button in the top panel
		this.panel_button = new PanelMenu.Button(0.0, _("Show notes"), false);
		let icon = new St.Icon({
			icon_name: 'document-edit-symbolic',
			style_class: 'system-status-icon'
		});
		if(USE_ACTORS) {
			this.panel_button.actor.add_child(icon);
			this.panel_button.actor.connect(
				'button-press-event',
				this._toggleState.bind(this)
			);
		} else {
			this.panel_button.add_child(icon);
			this.panel_button.connect(
				'button-press-event',
				this._toggleState.bind(this)
			);
		}
		this._updateIconVisibility();
		// `0` is the position within the chosen box (here, the `right` one)
		Main.panel.addToStatusArea('NotesButton', this.panel_button, 0, 'right');

		// Initialisation of the notes themselves
		this._allNotes = new Array();
		this._notesAreVisible = false;
		this._updateLayoutSetting(); // it inits Z_POSITION

		this._notesLoaded = false; // this will tell the toggleState method that
		// notes need to be loaded first, thus doing the actual initilisation

		// Initialisation of the signals connections
		this._bindShortcut();
		this._connectAllSignals();
	}

	_bindShortcut () {
		this.USE_SHORTCUT = Convenience.getSettings().get_boolean('use-shortcut');
		if (!this.USE_SHORTCUT) { return; }

		Main.wm.addKeybinding(
			'notes-kb-shortcut',
			Convenience.getSettings(),
			Meta.KeyBindingFlags.NONE,
			Shell.ActionMode.ALL,
			this._toggleState.bind(this)
		);
	}

	_loadAllNotes () {
		let i = 0;
		let ended = false;
		while(!ended) {
			let file2 = GLib.build_filenamev([PATH, i.toString() + '_state']);
			if (GLib.file_test(file2, GLib.FileTest.EXISTS)) {
				this.createNote('', 16);
			} else {
				ended = true;
			}
			i++;
		}
		this._onlyHideNotes();
		this._notesLoaded = true;
	}

	//--------------------------------------------------------------------------
	// "Public" methods, accessed by the NoteBox objects -----------------------

	createNote (colorString, fontSize) {
		let nextId = this._allNotes.length;
		try {
			this._allNotes.push(new NoteBox.NoteBox(nextId, colorString, fontSize));
		} catch (e) {
			Main.notify(_("Notes extension error: failed to load a note"));
			log('failed to create note n°' + nextId.toString());
			log(e);
		}
	}

	/*
	 * When a NoteBox object deletes itself, it calls this method to ensure the
	 * files go from 0 to (this._allNotes.length - 1) without any "gap" in the
	 * numerotation.
	 */
	postDelete (deletedNoteId) {
		let lastNote = this._allNotes.pop();
		if (deletedNoteId < this._allNotes.length) {
			this._allNotes[deletedNoteId] = lastNote;
			lastNote.id = deletedNoteId;
			this._allNotes[deletedNoteId].onlySave(true);
		}
		this._deleteNoteFiles(this._allNotes.length);
	}

	/*
	 * Tells if [x, y] are suitable coords for a note (= not too close of the
	 * other existing notes). Called by NoteBox objects on various occasions,
	 * for example when brought back to the primary monitor, or when deciding
	 * the initial coords at the creation of the note.
	 */
	areCoordsUsable (x, y) {
		let areaIsFree = true;
		this._allNotes.forEach(function (n) {
			if( (Math.abs(n._x - x) < 230) && (Math.abs(n._y - y) < 100) ) {
				areaIsFree = false;
			}
		});
		return areaIsFree;
	}

	//--------------------------------------------------------------------------

	_toggleState () {
		if(!this._notesLoaded) {
			this._loadAllNotes();
		}

		// log('_toggleState');
		if(this._allNotes.length == 0) {
			this.createNote('', 16);
			this._showNotes();
		} else if (this._notesAreVisible) {
			this._hideNotes();
		} else {
			this._showNotes();
		}
	}

	_showNotes () {
		this._notesAreVisible = true;
		this._allNotes.forEach(function (n) {
			n.show();
		});
	}

	_hideNotes () {
		this._onlyHideNotes();
		let timeout_id = Mainloop.timeout_add(10, () => {
			// saving to the disk is slightly delayed to give the illusion that
			// the extension doesn't freeze the system
			this._allNotes.forEach(function (n) {
				n.onlySave(false);
			});
			Mainloop.source_remove(timeout_id);
		});
	}

	_onlyHideNotes () {
		this._allNotes.forEach(function (n) {
			n.onlyHide();
		});
		this._notesAreVisible = false;
	}

	_deleteNoteFiles (id) {
		let filePathBeginning = PATH + '/' + id.toString();
		let textfile = Gio.file_new_for_path(filePathBeginning + '_text');
		let statefile = Gio.file_new_for_path(filePathBeginning + '_state');
		textfile.delete(null); // may not do anything
		statefile.delete(null); // may not do anything
	}

	//--------------------------------------------------------------------------
	// Watch the gsettings values and update the extension if they change ------

	_connectAllSignals () {
		this._settingsSignals = {};

		this._settingsSignals['layout'] = SETTINGS.connect(
			'changed::layout-position',
			this._updateLayoutSetting.bind(this)
		);
		this._settingsSignals['bring-back'] = SETTINGS.connect(
			'changed::ugly-hack',
			this._bringToPrimaryMonitorOnly.bind(this)
		);
		this._settingsSignals['hide-icon'] = SETTINGS.connect(
			'changed::hide-icon',
			this._updateIconVisibility.bind(this)
		);
		this._settingsSignals['kb-shortcut-1'] = SETTINGS.connect(
			'changed::use-shortcut',
			this._updateShortcut.bind(this)
		);
		this._settingsSignals['kb-shortcut-2'] = SETTINGS.connect(
			'changed::notes-kb-shortcut',
			this._updateShortcut.bind(this)
		);
		this._settingsSignals['auto-focus'] = SETTINGS.connect(
			'changed::auto-focus',
			this._updateFocusSetting.bind(this)
		);
	}

	_updateShortcut () {
		if(this.USE_SHORTCUT) {
			Main.wm.removeKeybinding('notes-kb-shortcut');
		}
		this._bindShortcut();
	}

	_updateFocusSetting () {
		// XXX currently not very user-friendly
		Main.notify(
			_("Notes"),
			_("Restart the extension to apply the changes")
		);
	}

	_updateIconVisibility () {
		let now_visible = !Convenience.getSettings().get_boolean('hide-icon');
		if(USE_ACTORS) {
			this.panel_button.actor.visible = now_visible;
		} else {
			this.panel_button.visible = now_visible;
		}
	}

	_bringToPrimaryMonitorOnly () {
		this._allNotes.forEach(function (n) {
			n.fixState();
		});
	}

	/*
	 * Remove all the notes from where they are, and add them to the layer that
	 * is actually set by the user. Possible values for the layers can be
	 * 'above-all', 'on-background' or 'cycle-layers'.
	 */
	_updateLayoutSetting () {
		this._allNotes.forEach(function (n) {
			n.removeFromCorrectLayer();
		});

		Z_POSITION = SETTINGS.get_string('layout-position');

		this._allNotes.forEach(function (n) {
			n.loadIntoCorrectLayer();
		});

		if(!this._notesAreVisible) {
			this._onlyHideNotes();
		}
	}

	//--------------------------------------------------------------------------

	destroy() {
		SETTINGS.disconnect(this._settingsSignals['layout']);
		SETTINGS.disconnect(this._settingsSignals['bring-back']);
		SETTINGS.disconnect(this._settingsSignals['hide-icon']);
		SETTINGS.disconnect(this._settingsSignals['kb-shortcut-1']);
		SETTINGS.disconnect(this._settingsSignals['kb-shortcut-2']);
		SETTINGS.disconnect(this._settingsSignals['auto-focus']);

		this._allNotes.forEach(function (n) {
			n.onlySave(false);
			n.destroy();
		});

		if(this.USE_SHORTCUT) {
			Main.wm.removeKeybinding('notes-kb-shortcut');
		}

		this.panel_button.destroy();
	}
};

//------------------------------------------------------------------------------

