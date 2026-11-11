# Yoda Web User Guide

Yoda Web is a browser interface for a Yoda backend. You need a reachable
backend, an account and access to a contest. Interface labels can vary with
the selected language; the names below use English.

## Sign in and select a contest

1. Open the Yoda Web address provided by your administrator and sign in.
2. Select **Switch Contest** in the sidebar and choose a contest.
3. The **Dashboard** shows contest progress, problems and recent submissions.
   Select a problem to read its description.

The sidebar also opens **Codeboard**, **Submissions**, **Settings** and
**Sign out**. Judges and administrators can additionally open **Judge board**.
On smaller screens, sidebar items may appear as icons.

## Work on a problem

1. Open **Codeboard** and select a problem from the problem dropdown.
2. Edit the source files in the editor. Use the file tabs to switch between
   files. The code actions include downloading all files as a ZIP, copying
   code and restoring the problem skeleton. Confirm before replacing work
   with the skeleton.
3. Use the test panel to add or remove test inputs and choose text or JSON
   input. JSON input must be valid JSON.
4. Choose **Evaluate** and confirm to submit your work for judging. The
   evaluation dialog shows the submission's progress and verdict.
5. Open **Submissions** to inspect the result.

The editor can automatically save work in the browser. The status bar shows
the save status; auto-save and editor preferences are configurable in
**Settings**. A browser save is not a judged submission: use **Evaluate**
to submit.

## Review submissions

Open **Submissions** to see recent submissions for the selected contest.
Use **Only mine** to filter the list and column headings to sort it. Where
available, the action buttons open test results or source artifacts. Test
results can include status, execution time and output; unavailable details
are indicated in the interface. Judges and administrators can request
reevaluation.

## Change personal settings

Open **Settings**:

- **General**: adjust the language, appearance, editor font size, tab size,
  line wrapping and auto-save. Use the provided save or reset controls.
- **Password**: change your password.

Sign out using the sidebar when finished, especially on shared computers.

## Judge board

The judge board is available to judges and administrators for the selected
contest.

1. Open **Judge board** to see verdict counts by problem. These counts
   include all submissions, not only the latest submission per user.
2. Use **View submissions for** to switch between the contest overview and
   an individual user. Usernames may be unavailable without access to the
   administrator user list.
3. Select file distance metrics to compare source files. The analysis covers
   accessible files from the current view's latest 50 submissions, comparing
   an earlier file with the same user, problem and filename. An empty
   comparison can mean there is no previous file; large edit-distance
   comparisons can also exceed the calculation limit.
4. Use **Refresh** to reload submissions or **Recalculate file distances**
   to rerun the analysis. The submission review table offers available
   results, source and reevaluation actions.
5. Use **Export CSV** for statistics in the current user view.

### Export submission statistics

The CSV contains one row for each user's latest submission for each problem
in the selected view, with the total number of attempts. Submissions without
a known owner are listed separately with one attempt. The export fetches
details only for the latest submissions.

The **Test results** column lists the latest submission's test case IDs,
verdicts and execution times, one per line; it is empty when no results are
available.

### Optional LLM evaluation

Judges and administrators can configure a provider, model, API key and prompt
under **Settings > LLM evaluation**. On the judge board, evaluation actions
send source code to the configured provider only when requested. The
contest-wide **Evaluate latest per user** action lets you select a problem
and review a preview before confirming the batch.

Review your organization's policy before sending code to an external
provider. LLM responses are judging aids, not proof of authorship. Successful
responses are saved in the browser; provider configuration, including the
API key, is also stored there, so take care on shared devices.

## Judge and administrator settings

- **Problems** (judges and administrators): manage problems for a selected
  contest, including test cases and artifacts. Import and export controls
  are available in the problem settings.
- **Contests** (administrators): create, edit and delete contests.
- **Users** (administrators): manage users and import users from CSV.
- **Stats** (administrators): view backend request, submission and job
  statistics.
- **YodaC** (administrators): inspect and edit judge configuration and
  view its history.

Available operations and data also depend on backend permissions and contest
configuration. If the application cannot reach the API, see the
[troubleshooting guide](troubleshooting.md).
