function ghactionstatus --description 'Check github ci action status for particular pr. By default - build images for deckhouse/virtualization'
    argparse --min-args=1 'h/help' 'v/verbose' 'repo=' 'action=+' -- $argv
    or return
    if not command -q gh
        echo "Error. Please install 'gh' command (github cli)" >&2
        return 1
    end
    if set -ql _flag_h
        echo "Usage: ghactionstatus [--help] [--repo=owner/repo_name] [--action=action_name] pr_number" >&2
        echo "-h/--help - show this help" >&2
        echo "-v/--verbose - show pr and changed file names except '.go'" >&2
        echo "--repo= - repository owner and name" >&2
        echo "--action=+ - full action name" >&2
        echo "pr_number - mandatory option, just pr number" >&2
        echo "defaults: --repo='deckhouse/virtualization' --action='Build and Push images' --action='Validation doc-changes'" >&2
        return 1
    end

    set --local pr_number "$argv[1]"

    set --local owner_repo "deckhouse/virtualization"
    set -ql _flag_repo[1]
    and set --local owner_repo $_flag_repo[-1]

    set --local action_names "Build and Push images" "Validation doc-changes";
    set -ql _flag_action[1]
    and set --local action_names $_flag_action

    if set -ql _flag_verbose
        gh --repo $owner_repo pr view $pr_number
        gh --repo $owner_repo pr diff --name-only $pr_number | grep -vE '\.go|\.mod'
    end

    set --local commit "$(gh pr view $pr_number --repo $owner_repo --json commits --jq ".commits[-1].oid")"
    for action in $action_names
        gh api repos/$owner_repo/commits/$commit/check-runs --jq ".check_runs[] | select(.name==\"$action\") | {name: .name, status: .status, conclusion: .conclusion, completed_at: .completed_at}"
    end
end
