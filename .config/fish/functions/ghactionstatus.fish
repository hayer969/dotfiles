function ghactionstatus --description 'Check github ci action status for particular pr. By default - build images for deckhouse/virtualization'
    argparse --min-args=1 'h/help' 'build' 'docs' 'repo=' 'action=' -- $argv
    or return
    if not command -q gh
        echo "Error. Please install 'gh' command (github cli)" >&2
        return 1
    end
    if set -ql _flag_h
        echo "Usage: ghactionstatus [--help] [--docs] [--repo=owner/repo_name] [--action=action_name] pr_number"
        echo "-h/--help - show this help"
        echo "--docs - equal to --action='Validation doc-changes'"
        echo "--repo= - repository owner and name"
        echo "--action= - full action name"
        echo "pr_number - mandatory option, just pr number"
        echo "defaults: --repo='deckhouse/virtualization' --action='Build and Push images'"
        return
    end

    set --local pr_number "$argv[1]"

    set --local owner_repo "deckhouse/virtualization"
    set -ql _flag_repo[1]
    and set --local owner_repo $_flag_repo[-1]

    set --local action_name "Build and Push images";
    set -ql _flag_docs
    and set --local action_name "Validation doc-changes"

    set -ql _flag_action[1]
    and set --local action_name $_flag_action[-1]


    set --local commit "$(gh pr view $pr_number --repo $owner_repo --json commits --jq ".commits[-1].oid")"
    gh api repos/$owner_repo/commits/$commit/check-runs --jq ".check_runs[] | select(.name==\"$action_name\") | {name: .name, status: .status, conclusion: .conclusion, completed_at: .completed_at}"
end
