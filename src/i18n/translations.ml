type translations =
  { login_placeholder_email: string
  ; login_placeholder_password: string
  ; login_sign_in: string
  ; login_title: string
  ; login_label_email: string
  ; login_label_password: string
  ; login_remember_me: string
  ; login_session_expired: string
  ; login_footer: string
  ; sidebar_app_name: string
  ; status_checking_title: string
  ; status_checking_description: string
  ; status_maintenance_title: string
  ; status_maintenance_description: string
  ; status_unavailable_title: string
  ; status_unavailable_description: string
  ; status_retry_countdown: string
  ; status_retrying: string
  ; tabbar_actions_label: string
  ; tabbar_download_title: string
  ; tabbar_copy: string
  ; tabbar_copy_title: string
  ; tabbar_confirm_skeleton: string
  ; tabbar_skeleton: string
  ; tabbar_set_skeleton_title: string
  ; codebar_all_changes_saved: string
  ; codebar_saving: string
  ; codebar_auto_save_disabled: string
  ; spinner_modal_processing: string
  ; spinner_modal_ready: string
  ; codebar_local_run: string
  ; codebar_evaluate: string
  ; codebar_confirm_save: string
  ; codebar_evaluate_save: string
  ; codebar_run: string
  ; codebar_confirm_run: string
  ; modal_cancel: string
  ; modal_confirm: string
  ; modal_confirm_action: string
  ; submission_sending: string
  ; submission_problem_check_failed: string
  ; submission_problem_force_closed: string
  ; submission_no_problem: string
  ; submission_no_language: string
  ; submission_empty_editor: string
  ; submission_preparing: string
  ; submission_history: string
  ; submission_cannot_submit: string
  ; submission_sending_language: string
  ; submission_failed_http: string
  ; submission_created: string
  ; submission_queued: string
  ; submission_status_polling: string
  ; submission_done: string
  ; submission_final_verdict: string
  ; submission_status_accepted: string
  ; submission_status_wrong_answer: string
  ; submission_status_runtime_error: string
  ; submission_status_time_limit_exceeded: string
  ; submission_status_memory_limit_exceeded: string
  ; submission_status_compilation_error: string
  ; submission_status_presentation_error: string
  ; submission_status_internal_error: string
  ; submission_status_pending: string
  ; submission_status_queued: string
  ; submission_status_running: string
  ; submission_processing: string
  ; submission_result: string
  ; submission_view_results: string
  ; submission_view_errors: string
  ; submission_view_source: string
  ; modal_close: string
  ; problem_time_limit: string
  ; problem_memory_limit: string
  ; problem_description: string
  ; problem_input: string
  ; problem_output: string
  ; problem_not_found: string
  ; problem_submit_solution: string
  ; problem_submit_btn: string
  ; subform_placeholder_source: string
  ; subform_label_language: string
  ; subform_label_source: string
  ; subform_submit: string
  ; submissions_col_id: string
  ; submissions_col_owner: string
  ; submissions_col_problem: string
  ; submissions_col_language: string
  ; submissions_col_result: string
  ; submissions_col_time: string
  ; submissions_col_date: string
  ; submissions_col_action: string
  ; submissions_reevaluate: string
  ; submissions_recent_title: string
  ; submissions_show_more: string
  ; submissions_loading: string
  ; submissions_only_mine: string
  ; settings_import_zip_description: string
  ; settings_import_zip_button: string
  ; settings_import_zip_card_title: string
  ; contests_title: string
  ; problems_col_id: string
  ; problems_col_name: string
  ; problems_title: string
  ; settings_title: string
  ; settings_theme_label: string
  ; settings_theme_desc: string
  ; settings_font_size_label: string
  ; settings_font_size_desc: string
  ; settings_tab_size_label: string
  ; settings_tab_size_desc: string
  ; settings_wrap_lines: string
  ; settings_auto_save: string
  ; settings_save_btn: string
  ; settings_reset_btn: string
  ; settings_language_label: string
  ; config_editor_title: string
  ; config_history_title: string
  ; config_col_version: string
  ; config_col_timestamp: string
  ; config_col_changed_by: string
  ; config_col_action: string
  ; config_col_langs: string
  ; config_loading_history: string
  ; settings_appearance_title: string
  ; settings_editor_title: string
  ; settings_behavior_title: string
  ; settings_tab_general: string
  ; settings_tab_password: string
  ; settings_tab_yodac: string
  ; settings_tab_users: string
  ; settings_tab_stats: string
  ; settings_tab_problems: string
  ; settings_llm_evaluation: string
  ; settings_line_wrap_label: string
  ; settings_auto_save_label: string
  ; settings_admin_badge: string
  ; settings_judge_badge: string
  ; password_change_title: string
  ; password_change_description: string
  ; password_current_label: string
  ; password_new_label: string
  ; password_confirm_label: string
  ; password_change_submit: string
  ; password_validation_required: string
  ; password_validation_mismatch: string
  ; password_validation_same: string
  ; password_notice_updated: string
  ; password_error_current: string
  ; password_error_update: string
  ; config_meta_version: string
  ; config_meta_updated: string
  ; config_meta_by: string
  ; config_total_entries: string
  ; config_no_history: string
  ; config_save_no_changes: string
  ; config_edit_btn: string
  ; config_cancel_edit_btn: string
  ; progress_status_label: string
  ; progress_time_left_label: string
  ; progress_progress_label: string
  ; progress_title: string
  ; problem_progress_title: string
  ; problem_progress_open: string
  ; problem_progress_upcoming: string
  ; problem_progress_closed: string
  ; test_type_text: string
  ; test_type_json: string
  ; test_invalid_json: string
  ; dropdown_select_problem: string
  ; sidebar_dashboard: string
  ; sidebar_codeboard: string
  ; sidebar_submissions: string
  ; sidebar_switch_contest: string
  ; sidebar_settings: string
  ; sidebar_sign_out: string
  ; login_sign_out: string
  ; users_manage_title: string
  ; users_manage_subtitle: string
  ; users_loading: string
  ; users_refresh_btn: string
  ; users_create_title: string
  ; users_create_username_placeholder: string
  ; users_create_password: string
  ; users_create_password_placeholder: string
  ; users_groups_placeholder: string
  ; users_create_submit: string
  ; users_col_id: string
  ; users_col_username: string
  ; users_col_role: string
  ; users_col_groups: string
  ; users_col_created_at: string
  ; users_col_last_seen_at: string
  ; users_col_actions: string
  ; users_select_all: string
  ; users_delete_selected_btn: string
  ; users_delete_confirm: string
  ; users_delete_failed: string
  ; users_notice_deleted: string
  ; users_action_edit: string
  ; users_action_save: string
  ; users_action_cancel: string
  ; users_notice_created: string
  ; users_notice_updated: string
  ; users_validation_required: string
  ; users_import_in_progress: string
  ; users_import_summary: string
  ; users_import_invalid_header: string
  ; users_import_invalid_row: string
  ; users_import_invalid_role: string
  ; users_import_read_failed: string
  ; users_import_input_missing: string
  ; users_import_empty_file: string
  ; users_import_btn: string
  ; stats_loading: string
  ; stats_empty: string
  ; stats_refresh_btn: string
  ; stats_error_prefix: string
  ; stats_parse_error: string
  ; stats_yodab_info: string
  ; stats_yodab: string
  ; stats_yodac: string
  ; stats_api_version: string
  ; stats_yoda_version: string
  ; stats_contributors: string
  ; stats_requests_total: string
  ; stats_requests_per_minute: string
  ; stats_submissions_total: string
  ; stats_submissions_per_minute: string
  ; stats_queued_jobs_total: string
  ; stats_queued_jobs_per_minute: string
  ; stats_processed_jobs_total: string
  ; stats_processed_jobs_per_minute: string
  ; problems_manage_title: string
  ; problems_manage_subtitle: string
  ; problems_loading: string
  ; problems_search_placeholder: string
  ; problems_select_contest: string
  ; problems_no_contest: string
  ; problems_add_btn: string
  ; problems_add_title: string
  ; problems_edit_title: string
  ; problems_code_label: string
  ; problems_title_label: string
  ; problems_difficulty_label: string
  ; problems_time_limit_label: string
  ; problems_memory_limit_label: string
  ; problems_languages_label: string
  ; problems_disable_submissions_label: string
  ; problems_force_closed_label: string
  ; problems_description_label: string
  ; problems_input_spec_label: string
  ; problems_output_spec_label: string
  ; problems_cancel_btn: string
  ; problems_submit_btn: string
  ; problems_save_changes: string
  ; problems_delete_confirm: string
  ; problems_testcases_title: string
  ; problems_add_testcase: string
  ; problems_test_input_label: string
  ; problems_test_output_label: string
  ; problems_is_sample_label: string
  ; problems_edit_testcase: string
  ; problems_delete_testcase: string
  ; problems_easy: string
  ; problems_medium: string
  ; problems_hard: string
  ; problems_error_load: string
  ; problems_error_save: string
  ; problems_error_delete: string
  ; problems_success_created: string
  ; problems_success_updated: string
  ; problems_success_deleted: string
  ; problems_confirm_delete: string }

let en =
  { login_placeholder_email= "name@example.com"
  ; login_placeholder_password= "Password"
  ; login_sign_in= "Sign in"
  ; login_title= "Please sign in"
  ; login_label_email= "Email address"
  ; login_label_password= "Password"
  ; login_remember_me= "Remember me"
  ; login_session_expired= "Your session expired. Please sign in again."
  ; login_footer= "© The Yoda Team 2026"
  ; sidebar_app_name= "YodaApp"
  ; status_checking_title= "Yoda is checking the service right now"
  ; status_checking_description= "Checking if the service status is ready..."
  ; status_maintenance_title= "Yoda is tidying things up"
  ; status_maintenance_description=
      "The service is temporarily closed for maintenance. This page will \
       update automatically when Yoda is ready."
  ; status_unavailable_title= "Yoda cannot reach the service"
  ; status_unavailable_description=
      "Yoda could not check the service status. This page will update \
       automatically when Yoda is ready."
  ; status_retry_countdown= "Next attempt in %s seconds"
  ; status_retrying= "Checking service status now..."
  ; tabbar_actions_label= "Code actions"
  ; tabbar_download_title= "Download all files as ZIP"
  ; tabbar_copy= "Copy"
  ; tabbar_copy_title= "Copy all code to clipboard"
  ; tabbar_confirm_skeleton=
      "Do you want to replace the current code with the skeleton? All \
       unsaved changes will be lost."
  ; tabbar_skeleton= "Skeleton"
  ; tabbar_set_skeleton_title= "Set skeleton"
  ; codebar_all_changes_saved= "All changes saved"
  ; codebar_saving= "Saving..."
  ; codebar_auto_save_disabled= "Auto-save disabled"
  ; spinner_modal_processing= "Processing..."
  ; spinner_modal_ready= "Ready to start operation."
  ; codebar_local_run= "Local Run"
  ; codebar_evaluate= "Evaluate"
  ; codebar_confirm_save=
      "Do you want to evaluate and permanently save your work for '%s' ? \
       This action cannot be undone and will count towards your submission \
       limit."
  ; codebar_evaluate_save= "Evaluate and save all your work"
  ; modal_confirm_action= "Confirm action"
  ; submission_sending= "Sending your solution..."
  ; submission_problem_check_failed=
      "Cannot submit: failed to check problem status (HTTP %s)"
  ; submission_problem_force_closed=
      "Cannot submit: this problem is force closed"
  ; submission_no_problem= "No selected problem found"
  ; submission_no_language=
      "No language selected or allowed for this problem"
  ; submission_empty_editor= "Editor is empty, nothing to submit"
  ; submission_preparing= "Preparing submission..."
  ; submission_history= "History"
  ; submission_cannot_submit= "Cannot submit: %s"
  ; submission_sending_language= "Sending your %s solution..."
  ; submission_failed_http= "Submission failed with HTTP status %s"
  ; submission_created= "Submission #%s created. Waiting for judge..."
  ; submission_queued= "Submission queued..."
  ; submission_status_polling= "Status: %s (polling every 1s)"
  ; submission_done= "Done: %s"
  ; submission_final_verdict= "Final verdict: %s"
  ; submission_status_accepted= "Accepted"
  ; submission_status_wrong_answer= "Wrong answer"
  ; submission_status_runtime_error= "Runtime error"
  ; submission_status_time_limit_exceeded= "Time limit exceeded"
  ; submission_status_memory_limit_exceeded= "Memory limit exceeded"
  ; submission_status_compilation_error= "Compilation error"
  ; submission_status_presentation_error= "Presentation error"
  ; submission_status_internal_error= "Internal error"
  ; submission_status_pending= "Pending"
  ; submission_status_queued= "Queued"
  ; submission_status_running= "Running"
  ; submission_processing= "Processing your solution... (polling every 2s)"
  ; submission_result= "Result:"
  ; submission_view_results= "View results"
  ; submission_view_errors= "View errors"
  ; submission_view_source= "View submitted source"
  ; modal_close= "Close"
  ; codebar_run= "Run the code"
  ; codebar_confirm_run= "Do you want to run the '%s' code ?"
  ; modal_cancel= "Cancel"
  ; modal_confirm= "Confirm"
  ; problem_submit_solution= "Submit your solution below."
  ; problem_time_limit= "Time limit"
  ; problem_memory_limit= "Memory limit"
  ; problem_description= "Description"
  ; problem_input= "Input"
  ; problem_output= "Output"
  ; problem_not_found= "Problem not found"
  ; problem_submit_btn= "Submit"
  ; subform_placeholder_source= "Source code"
  ; subform_label_language= "Language:"
  ; subform_label_source= "Source code:"
  ; subform_submit= "Submit"
  ; submissions_col_id= "#"
  ; submissions_col_owner= "Owner"
  ; submissions_col_problem= "Problem"
  ; submissions_col_language= "Language"
  ; submissions_col_result= "Result"
  ; submissions_col_time= "Time"
  ; submissions_col_date= "Date"
  ; submissions_col_action= "Action"
  ; submissions_reevaluate= "Re-evaluate"
  ; submissions_recent_title= "Recent Submissions"
  ; submissions_show_more= "Show more"
  ; submissions_loading= "Loading submissions..."
  ; submissions_only_mine= "Only my submissions"
  ; contests_title= "Contests"
  ; problems_col_id= "ID"
  ; problems_col_name= "Problem"
  ; problems_title= "Problems"
  ; settings_title= "Settings"
  ; settings_theme_label= "Theme"
  ; settings_theme_desc= "Choose the editor color theme."
  ; settings_font_size_label= "Font Size"
  ; settings_font_size_desc= "Adjust the editor font size."
  ; settings_tab_size_label= "Tab Size"
  ; settings_tab_size_desc= "Number of spaces per tab indentation."
  ; settings_wrap_lines= "Wrap long lines in the editor."
  ; settings_auto_save= "Automatically save your code while typing."
  ; settings_save_btn= "Save"
  ; settings_reset_btn= "Reset"
  ; settings_language_label= "Language"
  ; settings_import_zip_description=
      "Select ZIP file to import problems. This will create new problems \
       from the contents of the ZIP file."
  ; settings_import_zip_button= "Import Problems"
  ; settings_import_zip_card_title= "Import Problems"
  ; config_editor_title= "Config Editor"
  ; config_history_title= "Configuration History"
  ; config_col_version= "Version"
  ; config_col_timestamp= "Timestamp"
  ; config_col_changed_by= "Changed By"
  ; config_col_action= "Action"
  ; config_col_langs= "Langs"
  ; config_loading_history= "Loading history..."
  ; settings_appearance_title= "Appearance"
  ; settings_editor_title= "Editor"
  ; settings_behavior_title= "Behavior"
  ; settings_tab_general= "General"
  ; settings_tab_password= "Password"
  ; settings_tab_yodac= "YodaC"
  ; settings_tab_users= "Users"
  ; settings_tab_stats= "Stats"
  ; settings_line_wrap_label= "Line Wrapping"
  ; settings_auto_save_label= "Auto-save"
  ; settings_admin_badge= "Admin Access"
  ; settings_judge_badge= "Judge Access"
  ; password_change_title= "Change password"
  ; password_change_description= "Update the password for your account."
  ; password_current_label= "Current password"
  ; password_new_label= "New password"
  ; password_confirm_label= "Confirm new password"
  ; password_change_submit= "Change password"
  ; password_validation_required= "All password fields are required."
  ; password_validation_mismatch= "The new passwords do not match."
  ; password_validation_same=
      "The new password must differ from the current password."
  ; password_notice_updated= "Password changed successfully."
  ; password_error_current= "The current password is incorrect."
  ; password_error_update= "Failed to change password."
  ; settings_tab_problems= "Problems"
  ; settings_llm_evaluation= "LLM evaluation"
  ; config_meta_version= "Version: %s"
  ; config_meta_updated= "Updated: %s"
  ; config_meta_by= "By: %s"
  ; config_total_entries= "Total entries: %s"
  ; config_no_history= "No history"
  ; config_save_no_changes= "No changes to save."
  ; config_edit_btn= "Edit"
  ; config_cancel_edit_btn= "Cancel Edit"
  ; progress_status_label= "Status: "
  ; progress_time_left_label= "Time Left: "
  ; progress_progress_label= "Progress"
  ; progress_title= "Contest Progress"
  ; problem_progress_title= "Problem Progress"
  ; problem_progress_open= "Open"
  ; problem_progress_upcoming= "Upcoming"
  ; problem_progress_closed= "Closed"
  ; test_type_text= "Text"
  ; test_type_json= "JSON"
  ; test_invalid_json= "Invalid JSON"
  ; dropdown_select_problem= "-- Select a problem --"
  ; sidebar_dashboard= "Dashboard"
  ; sidebar_codeboard= "Codeboard"
  ; sidebar_submissions= "Submissions"
  ; sidebar_switch_contest= "Switch Contest"
  ; sidebar_settings= "Settings"
  ; sidebar_sign_out= "Sign out"
  ; login_sign_out= "Sign out"
  ; users_manage_title= "User management"
  ; users_manage_subtitle=
      "Create accounts and update roles directly from this table."
  ; users_loading= "Loading users..."
  ; users_refresh_btn= "Refresh"
  ; users_create_title= "Add a new user"
  ; users_create_username_placeholder= "Username"
  ; users_create_password= "Password"
  ; users_create_password_placeholder= "Temporary password"
  ; users_groups_placeholder= "group-a, group-b"
  ; users_create_submit= "Create user"
  ; users_col_id= "ID"
  ; users_col_username= "Username"
  ; users_col_role= "Role"
  ; users_col_groups= "Groups"
  ; users_col_created_at= "Created"
  ; users_col_last_seen_at= "Last Seen"
  ; users_col_actions= "Actions"
  ; users_select_all= "Select all"
  ; users_delete_selected_btn= "Delete selected (%s)"
  ; users_delete_confirm= "Delete %s selected users?"
  ; users_delete_failed= "Failed to delete %s selected users."
  ; users_notice_deleted= "Selected users deleted successfully."
  ; users_action_edit= "Edit"
  ; users_action_save= "Save"
  ; users_action_cancel= "Cancel"
  ; users_notice_created= "User created successfully."
  ; users_notice_updated= "User updated successfully."
  ; users_validation_required=
      "Username and password are required for new users."
  ; users_import_in_progress= "Importing users..."
  ; users_import_summary= "Import completed: %s users created, %s errors."
  ; users_import_invalid_header=
      "Invalid CSV header. Expected: username,password,role,groups"
  ; users_import_invalid_row= "Invalid CSV row at line"
  ; users_import_invalid_role= "Invalid role at line"
  ; users_import_read_failed= "Failed to read the selected CSV file."
  ; users_import_input_missing=
      "Import file input is unavailable on this page."
  ; users_import_empty_file= "The selected CSV file is empty."
  ; users_import_btn= "Import users"
  ; stats_loading= "Loading stats..."
  ; stats_empty= "No stats available."
  ; stats_refresh_btn= "Refresh"
  ; stats_error_prefix= "Failed to load stats (HTTP %s)"
  ; stats_parse_error= "Failed to parse stats: %s"
  ; stats_yodab_info= "YodaB Info"
  ; stats_yodab= "YodaB Metrics"
  ; stats_yodac= "YodaC Metrics"
  ; stats_api_version= "API Version"
  ; stats_yoda_version= "Yoda Version"
  ; stats_contributors= "List of Contributors"
  ; stats_requests_total= "Requests Total"
  ; stats_requests_per_minute= "Requests per Minute"
  ; stats_submissions_total= "Submissions Total"
  ; stats_submissions_per_minute= "Submissions per Minute"
  ; stats_queued_jobs_total= "Queued Jobs"
  ; stats_queued_jobs_per_minute= "Queued Jobs per Minute"
  ; stats_processed_jobs_total= "Processed Jobs Total"
  ; stats_processed_jobs_per_minute= "Processed Jobs per Minute"
  ; problems_manage_title= "Problem Management"
  ; problems_manage_subtitle= "Add, edit, or remove problems and test cases."
  ; problems_loading= "Loading problems..."
  ; problems_search_placeholder= "Search problems..."
  ; problems_select_contest= "Select Contest"
  ; problems_no_contest= "No contest selected"
  ; problems_add_btn= "Add Problem"
  ; problems_add_title= "Add New Problem"
  ; problems_edit_title= "Edit Problem"
  ; problems_code_label= "Code"
  ; problems_title_label= "Title"
  ; problems_difficulty_label= "Difficulty"
  ; problems_time_limit_label= "Time Limit (ms)"
  ; problems_memory_limit_label= "Memory Limit (MB)"
  ; problems_languages_label= "Languages"
  ; problems_disable_submissions_label= "Disable submissions"
  ; problems_force_closed_label= "Force closed"
  ; problems_description_label= "Description"
  ; problems_input_spec_label= "Input Specification"
  ; problems_output_spec_label= "Output Specification"
  ; problems_cancel_btn= "Cancel"
  ; problems_submit_btn= "Submit"
  ; problems_save_changes= "Save Changes"
  ; problems_delete_confirm= "Delete this problem?"
  ; problems_testcases_title= "Test Cases"
  ; problems_add_testcase= "Add Test Case"
  ; problems_test_input_label= "Input"
  ; problems_test_output_label= "Output"
  ; problems_is_sample_label= "Sample"
  ; problems_edit_testcase= "Edit Test Case"
  ; problems_delete_testcase= "Delete Test Case?"
  ; problems_easy= "Easy"
  ; problems_medium= "Medium"
  ; problems_hard= "Hard"
  ; problems_error_load= "Failed to load problems: %s"
  ; problems_error_save= "Failed to save problem: %s"
  ; problems_error_delete= "Failed to delete problem."
  ; problems_success_created= "Problem created."
  ; problems_success_updated= "Problem updated."
  ; problems_success_deleted= "Problem deleted."
  ; problems_confirm_delete= "Confirm Delete" }

let de =
  { en with
    login_placeholder_email= "name@beispiel.de"
  ; login_placeholder_password= "Passwort"
  ; login_sign_in= "Anmelden"
  ; login_title= "Bitte anmelden"
  ; login_label_email= "E-Mail-Adresse"
  ; login_label_password= "Passwort"
  ; login_remember_me= "Angemeldet bleiben"
  ; login_session_expired=
      "Deine Sitzung ist abgelaufen. Bitte melde dich erneut an."
  ; login_footer= "© Das Yoda-Team 2026"
  ; status_checking_title= "Yoda überprüft gerade den Dienst"
  ; status_checking_description= "Der Dienststatus wird überprüft..."
  ; status_maintenance_title= "Yoda räumt gerade auf"
  ; status_maintenance_description=
      "Der Dienst ist vorübergehend wegen Wartungsarbeiten nicht verfügbar. \
       Diese Seite wird automatisch aktualisiert, sobald Yoda bereit ist."
  ; status_unavailable_title= "Yoda kann den Dienst nicht erreichen"
  ; status_unavailable_description=
      "Yoda konnte den Dienststatus nicht überprüfen. Diese Seite wird \
       automatisch aktualisiert, sobald Yoda bereit ist."
  ; status_retry_countdown= "Nächster Versuch in %s Sekunden"
  ; status_retrying= "Der Dienststatus wird jetzt überprüft..."
  ; tabbar_actions_label= "Code-Aktionen"
  ; tabbar_download_title= "Alle Dateien als ZIP herunterladen"
  ; tabbar_copy= "Kopieren"
  ; tabbar_copy_title= "Den gesamten Code in die Zwischenablage kopieren"
  ; tabbar_confirm_skeleton=
      "Möchtest du den aktuellen Code durch das Grundgerüst ersetzen? Alle \
       nicht gespeicherten Änderungen gehen verloren."
  ; tabbar_skeleton= "Grundgerüst"
  ; tabbar_set_skeleton_title= "Grundgerüst festlegen"
  ; codebar_all_changes_saved= "Alle Änderungen gespeichert"
  ; codebar_saving= "Wird gespeichert..."
  ; codebar_auto_save_disabled= "Automatisches Speichern deaktiviert"
  ; spinner_modal_processing= "Wird verarbeitet..."
  ; spinner_modal_ready= "Bereit zum Start."
  ; codebar_local_run= "Lokal ausführen"
  ; codebar_evaluate= "Bewerten"
  ; codebar_confirm_save=
      "Möchtest du deine Arbeit für „%s“ bewerten und dauerhaft speichern? \
       Diese Aktion kann nicht rückgängig gemacht werden und zählt für dein \
       Abgabelimit."
  ; codebar_evaluate_save= "Gesamte Arbeit bewerten und speichern"
  ; modal_confirm_action= "Aktion bestätigen"
  ; submission_sending= "Deine Lösung wird gesendet..."
  ; submission_problem_check_failed=
      "Abgabe nicht möglich: Problemstatus konnte nicht überprüft werden \
       (HTTP %s)"
  ; submission_problem_force_closed=
      "Abgabe nicht möglich: Dieses Problem wurde zwangsweise geschlossen."
  ; submission_no_problem= "Kein Problem ausgewählt"
  ; submission_no_language=
      "Für dieses Problem wurde keine Sprache ausgewählt oder zugelassen"
  ; submission_empty_editor= "Der Editor ist leer. Es gibt nichts abzugeben."
  ; submission_preparing= "Abgabe wird vorbereitet..."
  ; submission_history= "Verlauf"
  ; submission_cannot_submit= "Abgabe nicht möglich: %s"
  ; submission_sending_language= "Deine Lösung in %s wird gesendet..."
  ; submission_failed_http= "Abgabe fehlgeschlagen (HTTP-Status %s)"
  ; submission_created= "Abgabe Nr. %s erstellt. Warte auf die Bewertung..."
  ; submission_queued= "Abgabe in die Warteschlange gestellt..."
  ; submission_status_polling= "Status: %s (Abfrage jede Sekunde)"
  ; submission_done= "Abgeschlossen: %s"
  ; submission_final_verdict= "Endgültiges Ergebnis: %s"
  ; submission_status_accepted= "Angenommen"
  ; submission_status_wrong_answer= "Falsche Antwort"
  ; submission_status_runtime_error= "Laufzeitfehler"
  ; submission_status_time_limit_exceeded= "Zeitlimit überschritten"
  ; submission_status_memory_limit_exceeded= "Speicherlimit überschritten"
  ; submission_status_compilation_error= "Kompilierungsfehler"
  ; submission_status_presentation_error= "Ausgabefehler"
  ; submission_status_internal_error= "Interner Fehler"
  ; submission_status_pending= "Ausstehend"
  ; submission_status_queued= "In der Warteschlange"
  ; submission_status_running= "Wird ausgeführt"
  ; submission_processing=
      "Deine Lösung wird verarbeitet... (Abfrage alle 2 Sekunden)"
  ; submission_result= "Ergebnis:"
  ; submission_view_results= "Ergebnisse ansehen"
  ; submission_view_errors= "Fehler ansehen"
  ; submission_view_source= "Eingereichten Quellcode ansehen"
  ; modal_close= "Schließen"
  ; codebar_run= "Code ausführen"
  ; codebar_confirm_run= "Möchtest du den Code „%s“ ausführen?"
  ; modal_cancel= "Abbrechen"
  ; modal_confirm= "Bestätigen"
  ; problem_submit_solution= "Reiche unten deine Lösung ein."
  ; problem_time_limit= "Zeitlimit"
  ; problem_memory_limit= "Speicherlimit"
  ; problem_description= "Beschreibung"
  ; problem_input= "Eingabe"
  ; problem_output= "Ausgabe"
  ; problem_not_found= "Problem nicht gefunden"
  ; problem_submit_btn= "Einreichen"
  ; subform_placeholder_source= "Quellcode"
  ; subform_label_language= "Sprache:"
  ; subform_label_source= "Quellcode:"
  ; subform_submit= "Einreichen"
  ; submissions_col_id= "#"
  ; submissions_col_owner= "Autor"
  ; submissions_col_problem= "Problem"
  ; submissions_col_language= "Sprache"
  ; submissions_col_result= "Ergebnis"
  ; submissions_col_time= "Zeit"
  ; submissions_col_date= "Datum"
  ; submissions_col_action= "Aktion"
  ; submissions_reevaluate= "Erneut bewerten"
  ; submissions_recent_title= "Letzte Abgaben"
  ; submissions_show_more= "Mehr anzeigen"
  ; submissions_loading= "Abgaben werden geladen..."
  ; submissions_only_mine= "Nur meine Abgaben"
  ; contests_title= "Wettbewerbe"
  ; problems_col_id= "ID"
  ; problems_col_name= "Problem"
  ; problems_title= "Probleme"
  ; settings_title= "Einstellungen"
  ; settings_theme_label= "Design"
  ; settings_theme_desc= "Wähle das Farbdesign des Editors."
  ; settings_font_size_label= "Schriftgröße"
  ; settings_font_size_desc= "Passe die Schriftgröße des Editors an."
  ; settings_tab_size_label= "Tabulatorgröße"
  ; settings_tab_size_desc= "Anzahl der Leerzeichen pro Einrückung."
  ; settings_wrap_lines= "Lange Zeilen im Editor umbrechen."
  ; settings_auto_save= "Code während der Eingabe automatisch speichern."
  ; settings_save_btn= "Speichern"
  ; settings_reset_btn= "Zurücksetzen"
  ; settings_language_label= "Sprache"
  ; settings_import_zip_description=
      "Wähle eine ZIP-Datei aus, um Probleme zu importieren. Aus dem Inhalt \
       der ZIP-Datei werden neue Probleme erstellt."
  ; settings_import_zip_button= "Probleme importieren"
  ; settings_import_zip_card_title= "Probleme importieren"
  ; config_editor_title= "Konfigurationseditor"
  ; config_history_title= "Konfigurationsverlauf"
  ; config_col_version= "Version"
  ; config_col_timestamp= "Zeitstempel"
  ; config_col_changed_by= "Geändert von"
  ; config_col_action= "Aktion"
  ; config_col_langs= "Sprachen"
  ; config_loading_history= "Verlauf wird geladen..."
  ; settings_appearance_title= "Darstellung"
  ; settings_editor_title= "Editor"
  ; settings_behavior_title= "Verhalten"
  ; settings_tab_general= "Allgemein"
  ; settings_tab_password= "Passwort"
  ; settings_tab_yodac= "YodaC"
  ; settings_tab_users= "Benutzer"
  ; settings_tab_stats= "Statistiken"
  ; settings_line_wrap_label= "Zeilenumbruch"
  ; settings_auto_save_label= "Automatisches Speichern"
  ; settings_admin_badge= "Administratorzugriff"
  ; settings_judge_badge= "Juryzugriff"
  ; password_change_title= "Passwort ändern"
  ; password_change_description= "Ändere das Passwort für dein Konto."
  ; password_current_label= "Aktuelles Passwort"
  ; password_new_label= "Neues Passwort"
  ; password_confirm_label= "Neues Passwort bestätigen"
  ; password_change_submit= "Passwort ändern"
  ; password_validation_required=
      "Alle Passwortfelder müssen ausgefüllt sein."
  ; password_validation_mismatch=
      "Die neuen Passwörter stimmen nicht überein."
  ; password_validation_same=
      "Das neue Passwort muss sich vom aktuellen Passwort unterscheiden."
  ; password_notice_updated= "Passwort erfolgreich geändert."
  ; password_error_current= "Das aktuelle Passwort ist falsch."
  ; password_error_update= "Passwort konnte nicht geändert werden."
  ; settings_tab_problems= "Probleme"
  ; settings_llm_evaluation= "LLM-Bewertung"
  ; config_meta_version= "Version: %s"
  ; config_meta_updated= "Aktualisiert: %s"
  ; config_meta_by= "Von: %s"
  ; config_total_entries= "Einträge insgesamt: %s"
  ; config_no_history= "Kein Verlauf"
  ; config_save_no_changes= "Keine Änderungen zum Speichern."
  ; config_edit_btn= "Bearbeiten"
  ; config_cancel_edit_btn= "Bearbeiten abbrechen"
  ; progress_status_label= "Status: "
  ; progress_time_left_label= "Verbleibende Zeit: "
  ; progress_progress_label= "Fortschritt"
  ; progress_title= "Wettbewerbsfortschritt"
  ; problem_progress_title= "Aufgabenfortschritt"
  ; problem_progress_open= "Offen"
  ; problem_progress_upcoming= "Bevorstehend"
  ; problem_progress_closed= "Geschlossen"
  ; test_type_text= "Text"
  ; test_type_json= "JSON"
  ; test_invalid_json= "Ungültiges JSON"
  ; dropdown_select_problem= "-- Problem auswählen --"
  ; sidebar_dashboard= "Übersicht"
  ; sidebar_codeboard= "Code-Editor"
  ; sidebar_submissions= "Abgaben"
  ; sidebar_switch_contest= "Wettbewerb wechseln"
  ; sidebar_settings= "Einstellungen"
  ; sidebar_sign_out= "Abmelden"
  ; login_sign_out= "Abmelden"
  ; users_manage_title= "Benutzerverwaltung"
  ; users_manage_subtitle=
      "Erstelle Konten und ändere Rollen direkt in dieser Tabelle."
  ; users_loading= "Benutzer werden geladen..."
  ; users_refresh_btn= "Aktualisieren"
  ; users_create_title= "Neuen Benutzer hinzufügen"
  ; users_create_username_placeholder= "Benutzername"
  ; users_create_password= "Passwort"
  ; users_create_password_placeholder= "Temporäres Passwort"
  ; users_groups_placeholder= "gruppe-a, gruppe-b"
  ; users_create_submit= "Benutzer erstellen"
  ; users_col_id= "ID"
  ; users_col_username= "Benutzername"
  ; users_col_role= "Rolle"
  ; users_col_groups= "Gruppen"
  ; users_col_created_at= "Erstellt"
  ; users_col_last_seen_at= "Zuletzt gesehen"
  ; users_col_actions= "Aktionen"
  ; users_select_all= "Alle auswählen"
  ; users_delete_selected_btn= "Ausgewählte löschen (%s)"
  ; users_delete_confirm= "%s ausgewählte Benutzer löschen?"
  ; users_delete_failed=
      "%s ausgewählte Benutzer konnten nicht gelöscht werden."
  ; users_notice_deleted= "Ausgewählte Benutzer erfolgreich gelöscht."
  ; users_action_edit= "Bearbeiten"
  ; users_action_save= "Speichern"
  ; users_action_cancel= "Abbrechen"
  ; users_notice_created= "Benutzer erfolgreich erstellt."
  ; users_notice_updated= "Benutzer erfolgreich aktualisiert."
  ; users_validation_required=
      "Für neue Benutzer sind Benutzername und Passwort erforderlich."
  ; users_import_in_progress= "Benutzer werden importiert..."
  ; users_import_summary=
      "Import abgeschlossen: %s Benutzer erstellt, %s Fehler."
  ; users_import_invalid_header=
      "Ungültige CSV-Kopfzeile. Erwartet: username,password,role,groups"
  ; users_import_invalid_row= "Ungültige CSV-Zeile in Zeile"
  ; users_import_invalid_role= "Ungültige Rolle in Zeile"
  ; users_import_read_failed=
      "Die ausgewählte CSV-Datei konnte nicht gelesen werden."
  ; users_import_input_missing=
      "Das Eingabefeld für die Importdatei ist auf dieser Seite nicht \
       verfügbar."
  ; users_import_empty_file= "Die ausgewählte CSV-Datei ist leer."
  ; users_import_btn= "Benutzer importieren"
  ; stats_loading= "Statistiken werden geladen..."
  ; stats_empty= "Keine Statistiken verfügbar."
  ; stats_refresh_btn= "Aktualisieren"
  ; stats_error_prefix= "Statistiken konnten nicht geladen werden (HTTP %s)"
  ; stats_parse_error= "Statistiken konnten nicht verarbeitet werden: %s"
  ; stats_yodab_info= "YodaB-Informationen"
  ; stats_yodab= "YodaB-Metriken"
  ; stats_yodac= "YodaC-Metriken"
  ; stats_api_version= "API-Version"
  ; stats_yoda_version= "Yoda-Version"
  ; stats_contributors= "Liste der Mitwirkenden"
  ; stats_requests_total= "Anfragen insgesamt"
  ; stats_requests_per_minute= "Anfragen pro Minute"
  ; stats_submissions_total= "Abgaben insgesamt"
  ; stats_submissions_per_minute= "Abgaben pro Minute"
  ; stats_queued_jobs_total= "Wartende Aufträge"
  ; stats_queued_jobs_per_minute= "Wartende Aufträge pro Minute"
  ; stats_processed_jobs_total= "Verarbeitete Aufträge insgesamt"
  ; stats_processed_jobs_per_minute= "Verarbeitete Aufträge pro Minute"
  ; problems_manage_title= "Problemverwaltung"
  ; problems_manage_subtitle=
      "Probleme und Testfälle hinzufügen, bearbeiten oder entfernen."
  ; problems_loading= "Probleme werden geladen..."
  ; problems_search_placeholder= "Probleme suchen..."
  ; problems_select_contest= "Wettbewerb auswählen"
  ; problems_no_contest= "Kein Wettbewerb ausgewählt"
  ; problems_add_btn= "Problem hinzufügen"
  ; problems_add_title= "Neues Problem hinzufügen"
  ; problems_edit_title= "Problem bearbeiten"
  ; problems_code_label= "Code"
  ; problems_title_label= "Titel"
  ; problems_difficulty_label= "Schwierigkeitsgrad"
  ; problems_time_limit_label= "Zeitlimit (ms)"
  ; problems_memory_limit_label= "Speicherlimit (MB)"
  ; problems_languages_label= "Sprachen"
  ; problems_disable_submissions_label= "Einreichungen deaktivieren"
  ; problems_force_closed_label= "Zwangsweise geschlossen"
  ; problems_description_label= "Beschreibung"
  ; problems_input_spec_label= "Eingabeformat"
  ; problems_output_spec_label= "Ausgabeformat"
  ; problems_cancel_btn= "Abbrechen"
  ; problems_submit_btn= "Einreichen"
  ; problems_save_changes= "Änderungen speichern"
  ; problems_delete_confirm= "Dieses Problem löschen?"
  ; problems_testcases_title= "Testfälle"
  ; problems_add_testcase= "Testfall hinzufügen"
  ; problems_test_input_label= "Eingabe"
  ; problems_test_output_label= "Ausgabe"
  ; problems_is_sample_label= "Beispiel"
  ; problems_edit_testcase= "Testfall bearbeiten"
  ; problems_delete_testcase= "Testfall löschen?"
  ; problems_easy= "Einfach"
  ; problems_medium= "Mittel"
  ; problems_hard= "Schwierig"
  ; problems_error_load= "Probleme konnten nicht geladen werden: %s"
  ; problems_error_save= "Problem konnte nicht gespeichert werden: %s"
  ; problems_error_delete= "Problem konnte nicht gelöscht werden."
  ; problems_success_created= "Problem erstellt."
  ; problems_success_updated= "Problem aktualisiert."
  ; problems_success_deleted= "Problem gelöscht."
  ; problems_confirm_delete= "Löschen bestätigen" }

let fr =
  { login_placeholder_email= "nom@exemple.com"
  ; login_placeholder_password= "Mot de passe"
  ; login_sign_in= "Se connecter"
  ; login_title= "Veuillez vous connecter"
  ; login_label_email= "Adresse e-mail"
  ; login_label_password= "Mot de passe"
  ; login_remember_me= "Se souvenir de moi"
  ; login_session_expired=
      "Votre session a expiré. Veuillez vous reconnecter."
  ; login_footer= "© L'équipe Yoda 2026"
  ; sidebar_app_name= "YodaApp"
  ; status_checking_title= "Yoda vérifie le service en ce moment"
  ; status_checking_description= "Vérification de l'état du service..."
  ; status_maintenance_title= "Yoda remet de l'ordre dans la maison"
  ; status_maintenance_description=
      "Le service est temporairement fermé pour maintenance. Cette page se \
       mettra à jour automatiquement dès que Yoda sera prêt."
  ; status_unavailable_title= "Yoda ne peut pas accéder au service"
  ; status_unavailable_description=
      "Yoda n'a pas pu vérifier l'état du service. Cette page se mettra à \
       jour automatiquement dès que Yoda sera prêt."
  ; status_retry_countdown= "Prochaine tentative dans %s secondes"
  ; status_retrying= "Vérification de l'état du service en cours..."
  ; tabbar_actions_label= "Actions du code"
  ; tabbar_download_title= "Télécharger tous les fichiers en ZIP"
  ; tabbar_copy= "Copier"
  ; tabbar_copy_title= "Copier tout le code dans le presse-papiers"
  ; tabbar_confirm_skeleton=
      "Voulez-vous remplacer le code actuel par le squelette ? Toutes les \
       modifications non enregistrées seront perdues."
  ; tabbar_skeleton= "Squelette"
  ; tabbar_set_skeleton_title= "Définir le squelette"
  ; codebar_all_changes_saved= "Toutes les modifications enregistrées"
  ; codebar_saving= "Enregistrement en cours..."
  ; codebar_auto_save_disabled= "Sauvegarde automatique désactivée"
  ; spinner_modal_processing= "Traitement en cours..."
  ; spinner_modal_ready= "Prêt à démarrer."
  ; codebar_local_run= "Exécution locale"
  ; codebar_evaluate= "Évaluer"
  ; codebar_confirm_save=
      "Voulez-vous évaluer et sauvegarder définitivement votre travail pour \
       '%s' ? Cette action est irréversible et comptera dans votre limite \
       de soumissions."
  ; codebar_evaluate_save= "Évaluer et sauvegarder tout votre travail"
  ; modal_confirm_action= "Confirmer l'action"
  ; submission_sending= "Envoi de votre solution..."
  ; submission_problem_check_failed=
      "Envoi impossible : vérification du statut du problème échouée (HTTP \
       %s)"
  ; submission_problem_force_closed=
      "Envoi impossible : ce problème a été fermé manuellement"
  ; submission_no_problem= "Aucun problème sélectionné"
  ; submission_no_language=
      "Aucun langage sélectionné ou autorisé pour ce problème"
  ; submission_empty_editor= "L'éditeur est vide, rien à soumettre"
  ; submission_preparing= "Préparation de la soumission..."
  ; submission_history= "Historique"
  ; submission_cannot_submit= "Envoi impossible : %s"
  ; submission_sending_language= "Envoi de votre solution en %s..."
  ; submission_failed_http= "Échec de la soumission (HTTP %s)"
  ; submission_created= "Soumission nº %s créée. En attente du juge..."
  ; submission_queued= "Soumission en file d'attente..."
  ; submission_status_polling=
      "Statut : %s (vérification toutes les secondes)"
  ; submission_done= "Terminé : %s"
  ; submission_final_verdict= "Verdict final : %s"
  ; submission_status_accepted= "Accepté"
  ; submission_status_wrong_answer= "Mauvaise réponse"
  ; submission_status_runtime_error= "Erreur d'exécution"
  ; submission_status_time_limit_exceeded= "Temps limite dépassé"
  ; submission_status_memory_limit_exceeded= "Mémoire limite dépassée"
  ; submission_status_compilation_error= "Erreur de compilation"
  ; submission_status_presentation_error= "Erreur de présentation"
  ; submission_status_internal_error= "Erreur interne"
  ; submission_status_pending= "En attente"
  ; submission_status_queued= "En file d'attente"
  ; submission_status_running= "En cours"
  ; submission_processing= "Traitement en cours... (sonde toutes les 2s)"
  ; submission_result= "Résultat :"
  ; submission_view_results= "Voir les résultats"
  ; submission_view_errors= "Voir les erreurs"
  ; submission_view_source= "Voir le code soumis"
  ; modal_close= "Fermer"
  ; codebar_run= "Exécuter le code"
  ; codebar_confirm_run= "Voulez-vous exécuter le code '%s' ?"
  ; modal_cancel= "Annuler"
  ; modal_confirm= "Confirmer"
  ; problem_submit_solution= "Soumettez votre solution ci-dessous."
  ; problem_time_limit= "Limite de temps"
  ; problem_memory_limit= "Limite de mémoire"
  ; problem_description= "Description"
  ; problem_input= "Entrée"
  ; problem_output= "Sortie"
  ; problem_not_found= "Problème non trouvé"
  ; problem_submit_btn= "Soumettre"
  ; subform_placeholder_source= "Code source"
  ; subform_label_language= "Langage :"
  ; subform_label_source= "Code source :"
  ; subform_submit= "Soumettre"
  ; submissions_col_id= "#"
  ; submissions_col_owner= "Propriétaire"
  ; submissions_col_problem= "Problème"
  ; submissions_col_language= "Langage"
  ; submissions_col_result= "Résultat"
  ; submissions_col_time= "Temps"
  ; submissions_col_date= "Date"
  ; submissions_col_action= "Action"
  ; submissions_reevaluate= "Réévaluer"
  ; submissions_recent_title= "Soumissions récentes"
  ; submissions_show_more= "Afficher plus"
  ; submissions_loading= "Chargement des soumissions..."
  ; submissions_only_mine= "Uniquement mes soumissions"
  ; contests_title= "Concours"
  ; problems_col_id= "ID"
  ; problems_col_name= "Problème"
  ; problems_title= "Problèmes"
  ; settings_title= "Paramètres"
  ; settings_theme_label= "Thème"
  ; settings_theme_desc= "Choisissez le thème de couleur de l'éditeur."
  ; settings_font_size_label= "Taille de police"
  ; settings_font_size_desc= "Ajustez la taille de la police de l'éditeur."
  ; settings_tab_size_label= "Taille des tabulations"
  ; settings_tab_size_desc= "Nombre d'espaces par indentation."
  ; settings_wrap_lines= "Activer le retour à la ligne automatique."
  ; settings_auto_save=
      "Sauvegarder automatiquement votre code pendant la frappe."
  ; settings_save_btn= "Enregistrer"
  ; settings_reset_btn= "Réinitialiser"
  ; settings_language_label= "Langue"
  ; settings_import_zip_description=
      "Sélectionnez le fichier ZIP à importer. Cela créera de nouveaux \
       problèmes à partir du contenu du fichier ZIP."
  ; settings_import_zip_button= "Importer les problèmes"
  ; settings_import_zip_card_title= "Importer les problèmes"
  ; config_editor_title= "Éditeur de configuration"
  ; config_history_title= "Historique des configurations"
  ; config_col_version= "Version"
  ; config_col_timestamp= "Horodatage"
  ; config_col_changed_by= "Modifié par"
  ; config_col_action= "Action"
  ; config_col_langs= "Langages"
  ; config_loading_history= "Chargement de l'historique..."
  ; settings_appearance_title= "Apparence"
  ; settings_editor_title= "Éditeur"
  ; settings_behavior_title= "Comportement"
  ; settings_tab_general= "Général"
  ; settings_tab_password= "Mot de passe"
  ; settings_tab_yodac= "YodaC"
  ; settings_tab_users= "Utilisateurs"
  ; settings_tab_problems= "Problèmes"
  ; settings_llm_evaluation= "Évaluation par LLM"
  ; settings_line_wrap_label= "Retour à la ligne"
  ; settings_auto_save_label= "Sauvegarde auto."
  ; settings_admin_badge= "Accès Administrateur"
  ; settings_judge_badge= "Accès Juge"
  ; password_change_title= "Changer le mot de passe"
  ; password_change_description=
      "Mettez à jour le mot de passe de votre compte."
  ; password_current_label= "Mot de passe actuel"
  ; password_new_label= "Nouveau mot de passe"
  ; password_confirm_label= "Confirmer le nouveau mot de passe"
  ; password_change_submit= "Changer le mot de passe"
  ; password_validation_required=
      "Tous les champs du mot de passe sont requis."
  ; password_validation_mismatch=
      "Les nouveaux mots de passe ne correspondent pas."
  ; password_validation_same=
      "Le nouveau mot de passe doit être différent de l'ancien."
  ; password_notice_updated= "Mot de passe modifié avec succès."
  ; password_error_current= "Le mot de passe actuel est incorrect."
  ; password_error_update= "Échec du changement de mot de passe."
  ; config_meta_version= "Version : %s"
  ; config_meta_updated= "Mis à jour : %s"
  ; config_meta_by= "Par : %s"
  ; config_total_entries= "Total des entrées : %s"
  ; config_no_history= "Aucun historique"
  ; config_save_no_changes= "Aucune modification à enregistrer."
  ; config_edit_btn= "Modifier"
  ; config_cancel_edit_btn= "Annuler"
  ; progress_status_label= "Statut : "
  ; progress_time_left_label= "Temps restant : "
  ; progress_progress_label= "Progression"
  ; progress_title= "Progression du concours"
  ; problem_progress_title= "Progression du problème"
  ; problem_progress_open= "Ouvert"
  ; problem_progress_upcoming= "À venir"
  ; problem_progress_closed= "Fermé"
  ; test_type_text= "Texte"
  ; test_type_json= "JSON"
  ; test_invalid_json= "JSON invalide"
  ; dropdown_select_problem= "-- Sélectionner un problème --"
  ; sidebar_dashboard= "Tableau de bord"
  ; sidebar_codeboard= "Codeboard"
  ; sidebar_submissions= "Soumissions"
  ; sidebar_switch_contest= "Changer de concours"
  ; sidebar_settings= "Paramètres"
  ; sidebar_sign_out= "Se déconnecter"
  ; login_sign_out= "Se déconnecter"
  ; users_manage_title= "Gestion des utilisateurs"
  ; users_manage_subtitle=
      "Créez des comptes et modifiez les rôles directement depuis ce \
       tableau."
  ; users_loading= "Chargement des utilisateurs..."
  ; users_refresh_btn= "Actualiser"
  ; users_create_title= "Ajouter un utilisateur"
  ; users_create_username_placeholder= "Nom d'utilisateur"
  ; users_create_password= "Mot de passe"
  ; users_create_password_placeholder= "Mot de passe temporaire"
  ; users_groups_placeholder= "groupe-a, groupe-b"
  ; users_create_submit= "Créer l'utilisateur"
  ; users_col_id= "ID"
  ; users_col_username= "Nom d'utilisateur"
  ; users_col_role= "Rôle"
  ; users_col_groups= "Groupes"
  ; users_col_created_at= "Créé le"
  ; users_col_last_seen_at= "Dernière activité"
  ; users_col_actions= "Actions"
  ; users_select_all= "Tout sélectionner"
  ; users_delete_selected_btn= "Supprimer la sélection (%s)"
  ; users_delete_confirm= "Supprimer %s utilisateurs sélectionnés ?"
  ; users_delete_failed=
      "Impossible de supprimer %s utilisateurs sélectionnés."
  ; users_notice_deleted= "Utilisateurs sélectionnés supprimés avec succès."
  ; users_action_edit= "Modifier"
  ; users_action_save= "Enregistrer"
  ; users_action_cancel= "Annuler"
  ; users_notice_created= "Utilisateur créé avec succès."
  ; users_notice_updated= "Utilisateur mis à jour avec succès."
  ; users_validation_required=
      "Le nom d'utilisateur et le mot de passe sont requis pour créer un \
       utilisateur."
  ; users_import_in_progress= "Importation des utilisateurs..."
  ; users_import_summary=
      "Import terminé : %s utilisateurs créés, %s erreurs."
  ; users_import_invalid_header=
      "En-tête CSV invalide. Attendu : username,password,role,groups"
  ; users_import_invalid_row= "Ligne CSV invalide à la ligne"
  ; users_import_invalid_role= "Rôle invalide à la ligne"
  ; users_import_read_failed=
      "Impossible de lire le fichier CSV sélectionné."
  ; users_import_input_missing=
      "Le champ de fichier d'import n'est pas disponible sur cette page."
  ; users_import_empty_file= "Le fichier CSV sélectionné est vide."
  ; users_import_btn= "Importer les utilisateurs"
  ; settings_tab_stats= "Statistiques"
  ; stats_loading= "Chargement des statistiques..."
  ; stats_empty= "Aucune statistique disponible."
  ; stats_refresh_btn= "Actualiser"
  ; stats_error_prefix= "Impossible de charger les statistiques (HTTP %s)"
  ; stats_parse_error= "Impossible d'analyser les statistiques : %s"
  ; stats_yodab_info= "Informations YodaB"
  ; stats_yodab= "Métriques YodaB"
  ; stats_yodac= "Métriques YodaC"
  ; stats_api_version= "Version API"
  ; stats_yoda_version= "Version Yoda"
  ; stats_contributors= "Liste des contributeurs"
  ; stats_requests_total= "Total des requêtes"
  ; stats_requests_per_minute= "Requêtes par minute"
  ; stats_submissions_total= "Total des soumissions"
  ; stats_submissions_per_minute= "Soumissions par minute"
  ; stats_queued_jobs_total= "Tâches en file"
  ; stats_queued_jobs_per_minute= "Tâches en file par minute"
  ; stats_processed_jobs_total= "Total des tâches traitées"
  ; stats_processed_jobs_per_minute= "Tâches traitées par minute"
  ; problems_manage_title= "Gestion des problèmes"
  ; problems_manage_subtitle=
      "Ajouter, modifier ou supprimer des problèmes et des cas de test."
  ; problems_loading= "Chargement des problèmes..."
  ; problems_search_placeholder= "Rechercher des problèmes..."
  ; problems_select_contest= "Sélectionner un concours"
  ; problems_no_contest= "Aucun concours sélectionné"
  ; problems_add_btn= "Ajouter un problème"
  ; problems_add_title= "Ajouter un nouveau problème"
  ; problems_edit_title= "Modifier le problème"
  ; problems_code_label= "Code"
  ; problems_title_label= "Titre"
  ; problems_difficulty_label= "Difficulté"
  ; problems_time_limit_label= "Limite de temps (ms)"
  ; problems_memory_limit_label= "Limite de mémoire (MB)"
  ; problems_languages_label= "Langages"
  ; problems_disable_submissions_label= "Désactiver les soumissions"
  ; problems_force_closed_label= "Fermeture forcée"
  ; problems_description_label= "Description"
  ; problems_input_spec_label= "Spécification d'entrée"
  ; problems_output_spec_label= "Spécification de sortie"
  ; problems_cancel_btn= "Annuler"
  ; problems_submit_btn= "Soumettre"
  ; problems_save_changes= "Enregistrer les modifications"
  ; problems_delete_confirm= "Supprimer ce problème ?"
  ; problems_testcases_title= "Cas de test"
  ; problems_add_testcase= "Ajouter un cas de test"
  ; problems_test_input_label= "Entrée"
  ; problems_test_output_label= "Sortie"
  ; problems_is_sample_label= "Exemple"
  ; problems_edit_testcase= "Modifier le cas de test"
  ; problems_delete_testcase= "Supprimer le cas de test ?"
  ; problems_easy= "Facile"
  ; problems_medium= "Moyen"
  ; problems_hard= "Difficile"
  ; problems_error_load= "Impossible de charger les problèmes : %s"
  ; problems_error_save= "Impossible d'enregistrer le problème : %s"
  ; problems_error_delete= "Impossible de supprimer le problème."
  ; problems_success_created= "Problème créé."
  ; problems_success_updated= "Problème mis à jour."
  ; problems_success_deleted= "Problème supprimé."
  ; problems_confirm_delete= "Confirmer la suppression" }

let es =
  { login_placeholder_email= "nombre@ejemplo.com"
  ; login_placeholder_password= "Contraseña"
  ; login_sign_in= "Iniciar sesión"
  ; login_title= "Por favor, inicie sesión"
  ; login_label_email= "Dirección de correo"
  ; login_label_password= "Contraseña"
  ; login_remember_me= "Recordarme"
  ; login_session_expired= "Tu sesión ha expirado. Vuelve a iniciar sesión."
  ; login_footer= "© El equipo Yoda 2026"
  ; sidebar_app_name= "YodaApp"
  ; status_checking_title= "Yoda está comprobando el servicio ahora mismo"
  ; status_checking_description=
      "Comprobando si el estado del servicio está listo..."
  ; status_maintenance_title= "Yoda está poniendo la casa en orden"
  ; status_maintenance_description=
      "El servicio está cerrado temporalmente por mantenimiento. Esta \
       página se actualizará automáticamente cuando Yoda esté listo."
  ; status_unavailable_title= "Yoda no puede acceder al servicio"
  ; status_unavailable_description=
      "Yoda no pudo comprobar el estado del servicio. Esta página se \
       actualizará automáticamente cuando Yoda esté listo."
  ; status_retry_countdown= "Próximo intento en %s segundos"
  ; status_retrying= "Comprobando el estado del servicio ahora..."
  ; tabbar_actions_label= "Acciones del código"
  ; tabbar_download_title= "Descargar todos los archivos como ZIP"
  ; tabbar_copy= "Copiar"
  ; tabbar_copy_title= "Copiar todo el código al portapapeles"
  ; tabbar_confirm_skeleton=
      "¿Quieres reemplazar el código actual por el esqueleto? Todas las \
       alteraciones no guardadas serán perdidas."
  ; tabbar_skeleton= "Esqueleto"
  ; tabbar_set_skeleton_title= "Establecer esqueleto"
  ; codebar_all_changes_saved= "Todos los cambios guardados"
  ; codebar_saving= "Guardando..."
  ; codebar_auto_save_disabled= "Guardado automático desactivado"
  ; spinner_modal_processing= "Procesando..."
  ; spinner_modal_ready= "Listo para comenzar."
  ; codebar_local_run= "Ejecución local"
  ; codebar_evaluate= "Evaluar"
  ; codebar_confirm_save=
      "¿Quieres evaluar y guardar permanentemente tu trabajo para '%s' ? \
       Esta acción no se puede deshacer y contará hacia tu límite de \
       envíos."
  ; codebar_evaluate_save= "Evaluar y guardar todo tu trabajo"
  ; modal_confirm_action= "Confirmar acción"
  ; submission_sending= "Enviando tu solución..."
  ; submission_problem_check_failed=
      "No se puede enviar: no se pudo comprobar el estado del problema \
       (HTTP %s)"
  ; submission_problem_force_closed=
      "No se puede enviar: este problema se ha cerrado manualmente"
  ; submission_no_problem= "No se ha seleccionado ningún problema"
  ; submission_no_language=
      "No se ha seleccionado un lenguaje permitido para este problema"
  ; submission_empty_editor= "El editor está vacío; no hay nada que enviar"
  ; submission_preparing= "Preparando el envío..."
  ; submission_history= "Historial"
  ; submission_cannot_submit= "No se puede enviar: %s"
  ; submission_sending_language= "Enviando tu solución en %s..."
  ; submission_failed_http= "Error al enviar la solución (HTTP %s)"
  ; submission_created= "Envío n.º %s creado. Esperando al juez..."
  ; submission_queued= "Envío en cola..."
  ; submission_status_polling= "Estado: %s (consultando cada segundo)"
  ; submission_done= "Finalizado: %s"
  ; submission_final_verdict= "Veredicto final: %s"
  ; submission_status_accepted= "Aceptado"
  ; submission_status_wrong_answer= "Respuesta incorrecta"
  ; submission_status_runtime_error= "Error de ejecución"
  ; submission_status_time_limit_exceeded= "Tiempo límite excedido"
  ; submission_status_memory_limit_exceeded= "Límite de memoria excedido"
  ; submission_status_compilation_error= "Error de compilación"
  ; submission_status_presentation_error= "Error de presentación"
  ; submission_status_internal_error= "Error interno"
  ; submission_status_pending= "Pendiente"
  ; submission_status_queued= "En cola"
  ; submission_status_running= "En ejecución"
  ; submission_processing= "Procesando tu solución... (consultando cada 2s)"
  ; submission_result= "Resultado:"
  ; submission_view_results= "Ver resultados"
  ; submission_view_errors= "Ver errores"
  ; submission_view_source= "Ver código enviado"
  ; modal_close= "Cerrar"
  ; codebar_run= "Ejecutar el código"
  ; codebar_confirm_run= "¿Quieres ejecutar el código '%s' ?"
  ; modal_cancel= "Cancelar"
  ; modal_confirm= "Confirmar"
  ; problem_submit_solution= "Envía tu solución abajo."
  ; problem_time_limit= "Límite de tiempo"
  ; problem_memory_limit= "Límite de memoria"
  ; problem_description= "Descripción"
  ; problem_input= "Entrada"
  ; problem_output= "Salida"
  ; problem_not_found= "Problema no encontrado"
  ; problem_submit_btn= "Enviar"
  ; subform_placeholder_source= "Código fuente"
  ; subform_label_language= "Lenguaje:"
  ; subform_label_source= "Código fuente:"
  ; subform_submit= "Enviar"
  ; submissions_col_id= "#"
  ; submissions_col_owner= "Propietario"
  ; submissions_col_problem= "Problema"
  ; submissions_col_language= "Lenguaje"
  ; submissions_col_result= "Resultado"
  ; submissions_col_time= "Tiempo"
  ; submissions_col_date= "Fecha"
  ; submissions_col_action= "Acción"
  ; submissions_reevaluate= "Re-evaluar"
  ; submissions_recent_title= "Envíos recientes"
  ; submissions_show_more= "Mostrar más"
  ; submissions_loading= "Cargando envíos..."
  ; submissions_only_mine= "Solo mis envíos"
  ; contests_title= "Concursos"
  ; problems_col_id= "ID"
  ; problems_col_name= "Problema"
  ; problems_title= "Problemas"
  ; settings_title= "Configuración"
  ; settings_theme_label= "Tema"
  ; settings_theme_desc= "Elige el tema de color del editor."
  ; settings_font_size_label= "Tamaño de fuente"
  ; settings_font_size_desc= "Ajusta el tamaño de la fuente del editor."
  ; settings_tab_size_label= "Tamaño de tabulación"
  ; settings_tab_size_desc= "Número de espacios por indentación."
  ; settings_wrap_lines= "Envolver líneas largas en el editor."
  ; settings_auto_save=
      "Guardar automáticamente tu código mientras escribes."
  ; settings_save_btn= "Guardar"
  ; settings_reset_btn= "Restablecer"
  ; settings_language_label= "Idioma"
  ; settings_import_zip_description=
      "Seleccione el archivo ZIP para importar problemas. Esto creará \
       nuevos problemas a partir del contenido del archivo ZIP."
  ; settings_import_zip_button= "Importar Problemas"
  ; settings_import_zip_card_title= "Importar Problemas"
  ; config_editor_title= "Editor de configuración"
  ; config_history_title= "Historial de configuración"
  ; config_col_version= "Versión"
  ; config_col_timestamp= "Marca de tiempo"
  ; config_col_changed_by= "Modificado por"
  ; config_col_action= "Acción"
  ; config_col_langs= "Idiomas"
  ; config_loading_history= "Cargando historial..."
  ; settings_appearance_title= "Apariencia"
  ; settings_editor_title= "Editor"
  ; settings_behavior_title= "Comportamiento"
  ; settings_tab_general= "General"
  ; settings_tab_password= "Contraseña"
  ; settings_tab_yodac= "YodaC"
  ; settings_tab_users= "Usuarios"
  ; settings_tab_problems= "Problemas"
  ; settings_llm_evaluation= "Evaluación por LLM"
  ; settings_line_wrap_label= "Envolver líneas"
  ; settings_auto_save_label= "Guardado automático"
  ; settings_admin_badge= "Acceso de Administrador"
  ; settings_judge_badge= "Acceso de Juez"
  ; password_change_title= "Cambiar contraseña"
  ; password_change_description= "Actualiza la contraseña de tu cuenta."
  ; password_current_label= "Contraseña actual"
  ; password_new_label= "Nueva contraseña"
  ; password_confirm_label= "Confirmar nueva contraseña"
  ; password_change_submit= "Cambiar contraseña"
  ; password_validation_required=
      "Todos los campos de contraseña son obligatorios."
  ; password_validation_mismatch= "Las nuevas contraseñas no coinciden."
  ; password_validation_same=
      "La nueva contraseña debe ser diferente de la actual."
  ; password_notice_updated= "Contraseña cambiada correctamente."
  ; password_error_current= "La contraseña actual es incorrecta."
  ; password_error_update= "No se pudo cambiar la contraseña."
  ; config_meta_version= "Versión: %s"
  ; config_meta_updated= "Actualizado: %s"
  ; config_meta_by= "Por: %s"
  ; config_total_entries= "Total de entradas: %s"
  ; config_no_history= "Sin historial"
  ; config_save_no_changes= "No hay cambios para guardar."
  ; config_edit_btn= "Editar"
  ; config_cancel_edit_btn= "Cancelar"
  ; progress_status_label= "Estado: "
  ; progress_time_left_label= "Tiempo restante: "
  ; progress_progress_label= "Progreso"
  ; progress_title= "Progreso del concurso"
  ; problem_progress_title= "Progreso del problema"
  ; problem_progress_open= "Abierto"
  ; problem_progress_upcoming= "Próximamente"
  ; problem_progress_closed= "Cerrado"
  ; test_type_text= "Texto"
  ; test_type_json= "JSON"
  ; test_invalid_json= "JSON inválido"
  ; dropdown_select_problem= "-- Seleccionar un problema --"
  ; sidebar_dashboard= "Tablero"
  ; sidebar_codeboard= "Codeboard"
  ; sidebar_submissions= "Envíos"
  ; sidebar_switch_contest= "Cambiar concurso"
  ; sidebar_settings= "Configuración"
  ; sidebar_sign_out= "Cerrar sesión"
  ; login_sign_out= "Cerrar sesión"
  ; users_manage_title= "Gestión de usuarios"
  ; users_manage_subtitle=
      "Crea cuentas y actualiza roles directamente desde esta tabla."
  ; users_loading= "Cargando usuarios..."
  ; users_refresh_btn= "Actualizar"
  ; users_create_title= "Agregar un usuario"
  ; users_create_username_placeholder= "Nombre de usuario"
  ; users_create_password= "Contraseña"
  ; users_create_password_placeholder= "Contraseña temporal"
  ; users_groups_placeholder= "grupo-a, grupo-b"
  ; users_create_submit= "Crear usuario"
  ; users_col_id= "ID"
  ; users_col_username= "Nombre de usuario"
  ; users_col_role= "Rol"
  ; users_col_groups= "Grupos"
  ; users_col_created_at= "Creado"
  ; users_col_last_seen_at= "Última actividad"
  ; users_col_actions= "Acciones"
  ; users_select_all= "Seleccionar todo"
  ; users_delete_selected_btn= "Eliminar seleccionados (%s)"
  ; users_delete_confirm= "¿Eliminar %s usuarios seleccionados?"
  ; users_delete_failed= "No se pudo eliminar %s usuarios seleccionados."
  ; users_notice_deleted= "Usuarios seleccionados eliminados correctamente."
  ; users_action_edit= "Editar"
  ; users_action_save= "Guardar"
  ; users_action_cancel= "Cancelar"
  ; users_notice_created= "Usuario creado correctamente."
  ; users_notice_updated= "Usuario actualizado correctamente."
  ; users_validation_required=
      "El nombre de usuario y la contraseña son obligatorios para crear un \
       usuario."
  ; users_import_in_progress= "Importando usuarios..."
  ; users_import_summary=
      "Importación completada: %s usuarios creados, %s errores."
  ; users_import_invalid_header=
      "Encabezado CSV inválido. Se espera: username,password,role,groups"
  ; users_import_invalid_row= "Fila CSV inválida en la línea"
  ; users_import_invalid_role= "Rol inválido en la línea"
  ; users_import_read_failed= "No se pudo leer el archivo CSV seleccionado."
  ; users_import_input_missing=
      "El campo de archivo para importar no está disponible en esta página."
  ; users_import_empty_file= "El archivo CSV seleccionado está vacío."
  ; users_import_btn= "Importar usuarios"
  ; settings_tab_stats= "Estadísticas"
  ; stats_loading= "Cargando estadísticas..."
  ; stats_empty= "No hay estadísticas disponibles."
  ; stats_refresh_btn= "Actualizar"
  ; stats_error_prefix= "No se pudieron cargar las estadísticas (HTTP %s)"
  ; stats_parse_error= "No se pudieron analizar las estadísticas: %s"
  ; stats_yodab_info= "Información de YodaB"
  ; stats_yodab= "Métricas de YodaB"
  ; stats_yodac= "Métricas de YodaC"
  ; stats_api_version= "Versión de API"
  ; stats_yoda_version= "Versión"
  ; stats_contributors= "Lista de contribuidores"
  ; stats_requests_total= "Solicitudes totales"
  ; stats_requests_per_minute= "Solicitudes por minuto"
  ; stats_submissions_total= "Envíos totales"
  ; stats_submissions_per_minute= "Envíos por minuto"
  ; stats_queued_jobs_total= "Trabajos en cola"
  ; stats_queued_jobs_per_minute= "Trabajos en cola por minuto"
  ; stats_processed_jobs_total= "Trabajos procesados totales"
  ; stats_processed_jobs_per_minute= "Trabajos procesados por minuto"
  ; problems_manage_title= "Gestión de problemas"
  ; problems_manage_subtitle=
      "Agrega, edita o elimina problemas y casos de prueba."
  ; problems_loading= "Cargando problemas..."
  ; problems_search_placeholder= "Buscar problemas..."
  ; problems_select_contest= "Seleccionar concurso"
  ; problems_no_contest= "Ningún concurso seleccionado"
  ; problems_add_btn= "Agregar problema"
  ; problems_add_title= "Agregar nuevo problema"
  ; problems_edit_title= "Editar problema"
  ; problems_code_label= "Código"
  ; problems_title_label= "Título"
  ; problems_difficulty_label= "Dificultad"
  ; problems_time_limit_label= "Límite de tiempo (ms)"
  ; problems_memory_limit_label= "Límite de memoria (MB)"
  ; problems_languages_label= "Idiomas"
  ; problems_disable_submissions_label= "Desactivar envíos"
  ; problems_force_closed_label= "Cierre forzado"
  ; problems_description_label= "Descripción"
  ; problems_input_spec_label= "Especificación de entrada"
  ; problems_output_spec_label= "Especificación de salida"
  ; problems_cancel_btn= "Cancelar"
  ; problems_submit_btn= "Enviar"
  ; problems_save_changes= "Guardar cambios"
  ; problems_delete_confirm= "¿Eliminar este problema?"
  ; problems_testcases_title= "Casos de prueba"
  ; problems_add_testcase= "Agregar caso de prueba"
  ; problems_test_input_label= "Entrada"
  ; problems_test_output_label= "Salida"
  ; problems_is_sample_label= "Ejemplo"
  ; problems_edit_testcase= "Editar caso de prueba"
  ; problems_delete_testcase= "¿Eliminar caso de prueba?"
  ; problems_easy= "Fácil"
  ; problems_medium= "Medio"
  ; problems_hard= "Difícil"
  ; problems_error_load= "No se pudieron cargar los problemas: %s"
  ; problems_error_save= "No se pudo guardar el problema: %s"
  ; problems_error_delete= "No se pudo eliminar el problema."
  ; problems_success_created= "Problema creado."
  ; problems_success_updated= "Problema actualizado."
  ; problems_success_deleted= "Problema eliminado."
  ; problems_confirm_delete= "Confirmar eliminación" }

let pt =
  { login_placeholder_email= "nome@exemplo.com"
  ; login_placeholder_password= "Senha"
  ; login_sign_in= "Entrar"
  ; login_title= "Por favor, faça login"
  ; login_label_email= "Endereço de e-mail"
  ; login_label_password= "Senha"
  ; login_remember_me= "Lembrar-me"
  ; login_session_expired= "Sua sessão expirou. Faça login novamente."
  ; login_footer= "© A equipe Yoda 2026"
  ; sidebar_app_name= "YodaApp"
  ; status_checking_title= "Yoda está neste momento a verificar o serviço"
  ; status_checking_description=
      "A verificar se o estado do serviço está pronto..."
  ; status_maintenance_title= "Yoda está a pôr a casa em ordem"
  ; status_maintenance_description=
      "O serviço está temporariamente fechado para manutenção. Esta página \
       será atualizada automaticamente quando Yoda estiver pronto."
  ; status_unavailable_title= "Yoda não consegue aceder ao serviço"
  ; status_unavailable_description=
      "Yoda não conseguiu verificar o estado do serviço. Esta página será \
       atualizada automaticamente quando Yoda estiver pronto."
  ; status_retry_countdown= "Próxima tentativa em %s segundos"
  ; status_retrying= "A verificar o estado do serviço agora..."
  ; tabbar_actions_label= "Ações de código"
  ; tabbar_download_title= "Baixar todos os arquivos em ZIP"
  ; tabbar_copy= "Copiar"
  ; tabbar_copy_title= "Copiar todo o código para a área de transferência"
  ; tabbar_confirm_skeleton=
      "Deseja substituir o código atual pelo esqueleto? Todas as alterações \
       não guardadas serão perdidas."
  ; tabbar_skeleton= "Esqueleto"
  ; tabbar_set_skeleton_title= "Definir esqueleto"
  ; codebar_all_changes_saved= "Todas as alterações guardadas"
  ; codebar_saving= "Guardando..."
  ; codebar_auto_save_disabled= "Gravação automática desativada"
  ; spinner_modal_processing= "Processando..."
  ; spinner_modal_ready= "Pronto para começar."
  ; codebar_local_run= "Execução local"
  ; codebar_evaluate= "Avaliar"
  ; codebar_confirm_save=
      "Deseja avaliar e guardar permanentemente o seu trabalho '%s' ? Esta \
       ação não pode ser desfeita e contará para o seu limite de \
       submissões."
  ; codebar_evaluate_save= "Avaliar e guardar todo o seu trabalho"
  ; modal_confirm_action= "Confirmar ação"
  ; submission_sending= "Enviando sua solução..."
  ; submission_problem_check_failed=
      "Não é possível submeter: não foi possível verificar o estado do \
       problema (HTTP %s)"
  ; submission_problem_force_closed=
      "Não é possível submeter: este problema foi fechado manualmente"
  ; submission_no_problem= "Nenhum problema selecionado"
  ; submission_no_language=
      "Nenhuma linguagem selecionada ou permitida para este problema"
  ; submission_empty_editor= "O editor está vazio; não há nada para submeter"
  ; submission_preparing= "A preparar a submissão..."
  ; submission_history= "Histórico"
  ; submission_cannot_submit= "Não é possível submeter: %s"
  ; submission_sending_language= "A enviar a sua solução em %s..."
  ; submission_failed_http= "Falha na submissão (HTTP %s)"
  ; submission_created= "Submissão n.º %s criada. A aguardar avaliação..."
  ; submission_queued= "Submissão em fila de espera..."
  ; submission_status_polling= "Estado: %s (verificação a cada segundo)"
  ; submission_done= "Concluído: %s"
  ; submission_final_verdict= "Veredito final: %s"
  ; submission_status_accepted= "Aceite"
  ; submission_status_wrong_answer= "Resposta errada"
  ; submission_status_runtime_error= "Erro de execução"
  ; submission_status_time_limit_exceeded= "Tempo limite excedido"
  ; submission_status_memory_limit_exceeded= "Limite de memória excedido"
  ; submission_status_compilation_error= "Erro de compilação"
  ; submission_status_presentation_error= "Erro de apresentação"
  ; submission_status_internal_error= "Erro interno"
  ; submission_status_pending= "Pendente"
  ; submission_status_queued= "Em fila de espera"
  ; submission_status_running= "Em execução"
  ; submission_processing=
      "Processando sua solução... (verificando a cada 2s)"
  ; submission_result= "Resultado:"
  ; submission_view_results= "Ver resultados"
  ; submission_view_errors= "Ver erros"
  ; submission_view_source= "Ver código enviado"
  ; modal_close= "Fechar"
  ; codebar_run= "Executar o código"
  ; codebar_confirm_run= "Deseja executar o código '%s' ?"
  ; modal_cancel= "Cancelar"
  ; modal_confirm= "Confirmar"
  ; problem_submit_solution= "Envie sua solução abaixo."
  ; problem_time_limit= "Tempo limite"
  ; problem_memory_limit= "Limite de memória"
  ; problem_description= "Descrição"
  ; problem_input= "Entrada"
  ; problem_output= "Saída"
  ; problem_not_found= "Problema não encontrado"
  ; problem_submit_btn= "Enviar"
  ; subform_placeholder_source= "Código fonte"
  ; subform_label_language= "Linguagem:"
  ; subform_label_source= "Código fonte:"
  ; subform_submit= "Enviar"
  ; submissions_col_id= "#"
  ; submissions_col_owner= "Proprietário"
  ; submissions_col_problem= "Problema"
  ; submissions_col_language= "Linguagem"
  ; submissions_col_result= "Resultado"
  ; submissions_col_time= "Tempo"
  ; submissions_col_date= "Data"
  ; submissions_col_action= "Ação"
  ; submissions_reevaluate= "Reavaliar"
  ; submissions_recent_title= "Envios recentes"
  ; submissions_show_more= "Mostrar mais"
  ; submissions_loading= "A carregar envios..."
  ; submissions_only_mine= "Apenas os meus envios"
  ; contests_title= "Concursos"
  ; problems_col_id= "ID"
  ; problems_col_name= "Problema"
  ; problems_title= "Problemas"
  ; settings_title= "Configurações"
  ; settings_theme_label= "Tema"
  ; settings_theme_desc= "Escolha o tema de cor do editor."
  ; settings_font_size_label= "Tamanho da fonte"
  ; settings_font_size_desc= "Ajuste o tamanho da fonte do editor."
  ; settings_tab_size_label= "Tamanho da tabulação"
  ; settings_tab_size_desc= "Número de espaços por indentação."
  ; settings_wrap_lines= "Quebrar linhas longas no editor."
  ; settings_auto_save= "Guardar automaticamente seu código enquanto digita."
  ; settings_save_btn= "Guardar"
  ; settings_reset_btn= "Redefinir"
  ; settings_language_label= "Idioma"
  ; settings_import_zip_description=
      "Selecione o arquivo ZIP para importar problemas. Isso criará novos \
       problemas a partir do conteúdo do arquivo ZIP."
  ; settings_import_zip_button= "Importar Problemas"
  ; settings_import_zip_card_title= "Importar Problemas"
  ; config_editor_title= "Editor de configuração"
  ; config_history_title= "Histórico de configurações"
  ; config_col_version= "Versão"
  ; config_col_timestamp= "Carimbo de data/hora"
  ; config_col_changed_by= "Alterado por"
  ; config_col_action= "Ação"
  ; config_col_langs= "Idiomas"
  ; config_loading_history= "Carregando histórico..."
  ; settings_appearance_title= "Aparência"
  ; settings_editor_title= "Editor"
  ; settings_behavior_title= "Comportamento"
  ; settings_tab_general= "Geral"
  ; settings_tab_password= "Senha"
  ; settings_tab_yodac= "YodaC"
  ; settings_tab_users= "Utilizadores"
  ; settings_tab_problems= "Problemas"
  ; settings_llm_evaluation= "Avaliação por LLM"
  ; settings_line_wrap_label= "Quebrar linhas"
  ; settings_auto_save_label= "Guarda de forma automática"
  ; settings_admin_badge= "Acesso de Administrador"
  ; settings_judge_badge= "Acesso de Juiz"
  ; password_change_title= "Alterar senha"
  ; password_change_description= "Atualize a senha da sua conta."
  ; password_current_label= "Senha atual"
  ; password_new_label= "Nova senha"
  ; password_confirm_label= "Confirmar nova senha"
  ; password_change_submit= "Alterar senha"
  ; password_validation_required=
      "Todos os campos de senha são obrigatórios."
  ; password_validation_mismatch= "As novas senhas não coincidem."
  ; password_validation_same= "A nova senha deve ser diferente da atual."
  ; password_notice_updated= "Senha alterada com sucesso."
  ; password_error_current= "A senha atual está incorreta."
  ; password_error_update= "Falha ao alterar a senha."
  ; config_meta_version= "Versão: %s"
  ; config_meta_updated= "Atualizado: %s"
  ; config_meta_by= "Por: %s"
  ; config_total_entries= "Total de entradas: %s"
  ; config_no_history= "Sem histórico"
  ; config_save_no_changes= "Não há alterações para guardar."
  ; config_edit_btn= "Editar"
  ; config_cancel_edit_btn= "Cancelar"
  ; progress_status_label= "Status: "
  ; progress_time_left_label= "Tempo restante: "
  ; progress_progress_label= "Progresso"
  ; progress_title= "Progresso do concurso"
  ; problem_progress_title= "Progresso do problema"
  ; problem_progress_open= "Aberto"
  ; problem_progress_upcoming= "Em breve"
  ; problem_progress_closed= "Encerrado"
  ; test_type_text= "Texto"
  ; test_type_json= "JSON"
  ; test_invalid_json= "JSON inválido"
  ; dropdown_select_problem= "-- Selecione um problema --"
  ; sidebar_dashboard= "Painel"
  ; sidebar_codeboard= "Codeboard"
  ; sidebar_submissions= "Envios"
  ; sidebar_switch_contest= "Trocar concurso"
  ; sidebar_settings= "Configurações"
  ; sidebar_sign_out= "Sair"
  ; login_sign_out= "Sair"
  ; users_manage_title= "Gestão de utilizadores"
  ; users_manage_subtitle=
      "Crie contas e atualize funções diretamente nesta tabela."
  ; users_loading= "Carregando utilizadores..."
  ; users_refresh_btn= "Atualizar"
  ; users_create_title= "Adicionar utilizador"
  ; users_create_username_placeholder= "Nome de utilizador"
  ; users_create_password= "Senha"
  ; users_create_password_placeholder= "Senha temporária"
  ; users_groups_placeholder= "grupo-a, grupo-b"
  ; users_create_submit= "Criar utilizador"
  ; users_col_id= "ID"
  ; users_col_username= "Nome de utilizador"
  ; users_col_role= "Função"
  ; users_col_groups= "Grupos"
  ; users_col_created_at= "Criado"
  ; users_col_last_seen_at= "Última atividade"
  ; users_col_actions= "Ações"
  ; users_select_all= "Selecionar tudo"
  ; users_delete_selected_btn= "Eliminar selecionados (%s)"
  ; users_delete_confirm= "Eliminar %s utilizadores selecionados?"
  ; users_delete_failed= "Falha ao eliminar %s utilizadores selecionados."
  ; users_notice_deleted= "Utilizadores selecionados eliminados com sucesso."
  ; users_action_edit= "Editar"
  ; users_action_save= "Guardar"
  ; users_action_cancel= "Cancelar"
  ; users_notice_created= "Utilizador criado com sucesso."
  ; users_notice_updated= "Utilizador atualizado com sucesso."
  ; users_validation_required=
      "Nome de utilizador e senha são obrigatórios para criar um utilizador."
  ; users_import_in_progress= "Importando utilizadores..."
  ; users_import_summary=
      "Importação concluída: %s utilizadores criados, %s erros."
  ; users_import_invalid_header=
      "Cabeçalho CSV inválido. Esperado: username,password,role,groups"
  ; users_import_invalid_row= "Linha CSV inválida na linha"
  ; users_import_invalid_role= "Função inválida na linha"
  ; users_import_read_failed= "Falha ao ler o ficheiro CSV selecionado."
  ; users_import_input_missing=
      "O campo de ficheiro de importação não está disponível nesta página."
  ; users_import_empty_file= "O ficheiro CSV selecionado está vazio."
  ; users_import_btn= "Importar utilizadores"
  ; settings_tab_stats= "Estatísticas"
  ; stats_loading= "Carregando estatísticas..."
  ; stats_empty= "Sem estatísticas disponíveis."
  ; stats_refresh_btn= "Atualizar"
  ; stats_error_prefix= "Falha ao carregar estatísticas (HTTP %s)"
  ; stats_parse_error= "Falha ao analisar estatísticas: %s"
  ; stats_yodab_info= "Informações do YodaB"
  ; stats_yodab= "Métricas do YodaB"
  ; stats_yodac= "Métricas do YodaC"
  ; stats_api_version= "Versão da API"
  ; stats_yoda_version= "Versão"
  ; stats_contributors= "Lista de contribuidores"
  ; stats_requests_total= "Total de requisições"
  ; stats_requests_per_minute= "Requisições por minuto"
  ; stats_submissions_total= "Total de envios"
  ; stats_submissions_per_minute= "Envios por minuto"
  ; stats_queued_jobs_total= "Tarefas na fila"
  ; stats_queued_jobs_per_minute= "Tarefas na fila por minuto"
  ; stats_processed_jobs_total= "Total de tarefas processadas"
  ; stats_processed_jobs_per_minute= "Tarefas processadas por minuto"
  ; problems_manage_title= "Gestão de problemas"
  ; problems_manage_subtitle=
      "Adicione, edite ou remova problemas e casos de teste."
  ; problems_loading= "Carregando problemas..."
  ; problems_search_placeholder= "Procurar problemas..."
  ; problems_select_contest= "Selecionar concurso"
  ; problems_no_contest= "Nenhum concurso selecionado"
  ; problems_add_btn= "Adicionar problema"
  ; problems_add_title= "Adicionar novo problema"
  ; problems_edit_title= "Editar problema"
  ; problems_code_label= "Código"
  ; problems_title_label= "Título"
  ; problems_difficulty_label= "Dificuldade"
  ; problems_time_limit_label= "Limite de tempo (ms)"
  ; problems_memory_limit_label= "Limite de memória (MB)"
  ; problems_languages_label= "Idiomas"
  ; problems_disable_submissions_label= "Desativar submissões"
  ; problems_force_closed_label= "Fecho forçado"
  ; problems_description_label= "Descrição"
  ; problems_input_spec_label= "Especificação de entrada"
  ; problems_output_spec_label= "Especificação de saída"
  ; problems_cancel_btn= "Cancelar"
  ; problems_submit_btn= "Enviar"
  ; problems_save_changes= "Guardar alterações"
  ; problems_delete_confirm= "Eliminar este problema?"
  ; problems_testcases_title= "Casos de teste"
  ; problems_add_testcase= "Adicionar caso de teste"
  ; problems_test_input_label= "Entrada"
  ; problems_test_output_label= "Saída"
  ; problems_is_sample_label= "Exemplo"
  ; problems_edit_testcase= "Editar caso de teste"
  ; problems_delete_testcase= "Eliminar caso de teste?"
  ; problems_easy= "Fácil"
  ; problems_medium= "Médio"
  ; problems_hard= "Difícil"
  ; problems_error_load= "Falha ao carregar problemas: %s"
  ; problems_error_save= "Falha ao guardar problema: %s"
  ; problems_error_delete= "Falha ao eliminar problema."
  ; problems_success_created= "Problema criado."
  ; problems_success_updated= "Problema atualizado."
  ; problems_success_deleted= "Problema eliminado."
  ; problems_confirm_delete= "Confirmar eliminação" }

let ar =
  { login_placeholder_email= "name@example.com"
  ; login_placeholder_password= "كلمة المرور"
  ; login_sign_in= "تسجيل الدخول"
  ; login_title= "يرجى تسجيل الدخول"
  ; login_label_email= "عنوان البريد الإلكتروني"
  ; login_label_password= "كلمة المرور"
  ; login_remember_me= "تذكرني"
  ; login_session_expired= "انتهت صلاحية جلستك. يرجى تسجيل الدخول مرة أخرى."
  ; login_footer= "© فريق يودا 2026"
  ; sidebar_app_name= "YodaApp"
  ; status_checking_title= "يودا يتحقق من الخدمة الآن"
  ; status_checking_description= "جارٍ التحقق من جاهزية حالة الخدمة..."
  ; status_maintenance_title= "يودا يعيد ترتيب الأمور"
  ; status_maintenance_description=
      "الخدمة مغلقة مؤقتًا للصيانة. سيتم تحديث هذه الصفحة تلقائيًا عندما يصبح \
       يودا جاهزًا."
  ; status_unavailable_title= "تعذر على يودا الوصول إلى الخدمة"
  ; status_unavailable_description=
      "تعذر على يودا التحقق من حالة الخدمة. سيتم تحديث هذه الصفحة تلقائيًا \
       عندما يصبح يودا جاهزًا."
  ; status_retry_countdown= "المحاولة التالية بعد %s ثانية"
  ; status_retrying= "جارٍ التحقق من حالة الخدمة الآن..."
  ; tabbar_actions_label= "إجراءات الكود"
  ; tabbar_download_title= "تنزيل كل الملفات بتنسيق ZIP"
  ; tabbar_copy= "نسخ"
  ; tabbar_copy_title= "نسخ كل الكود إلى الحافظة"
  ; tabbar_confirm_skeleton= "هل تريد استبدال الكود الحالي بالهيكل العظمي؟"
  ; tabbar_skeleton= "الهيكل"
  ; tabbar_set_skeleton_title= "تعيين الهيكل العظمي"
  ; codebar_all_changes_saved= "تم حفظ جميع التغييرات"
  ; codebar_saving= "جارٍ الحفظ..."
  ; codebar_auto_save_disabled= "تم تعطيل الحفظ التلقائي"
  ; spinner_modal_processing= "جارٍ المعالجة..."
  ; spinner_modal_ready= "جاهز للبدء."
  ; codebar_local_run= "تشغيل محلي"
  ; codebar_evaluate= "تقييم"
  ; codebar_confirm_save=
      "هل تريد تقييم وحفظ عملك بشكل دائم لـ '%s' ؟ لا يمكن التراجع عن هذا \
       الإجراء وسيتم احتسابه ضمن حد الإرسال الخاص بك."
  ; codebar_evaluate_save= "تقييم وحفظ كل عملك"
  ; modal_confirm_action= "تأكيد الإجراء"
  ; submission_sending= "جارٍ إرسال حلّك..."
  ; submission_problem_check_failed=
      "تعذّر الإرسال: فشل التحقق من حالة المسألة (HTTP %s)"
  ; submission_problem_force_closed=
      "تعذّر الإرسال: تم إغلاق هذه المسألة يدويًا"
  ; submission_no_problem= "لم يتم اختيار مسألة"
  ; submission_no_language= "لم يتم اختيار لغة مسموح بها لهذه المسألة"
  ; submission_empty_editor= "المحرر فارغ، لا يوجد ما يمكن إرساله"
  ; submission_preparing= "جارٍ تحضير الإرسال..."
  ; submission_history= "السجل"
  ; submission_cannot_submit= "تعذّر الإرسال: %s"
  ; submission_sending_language= "جارٍ إرسال حلّك بلغة %s..."
  ; submission_failed_http= "فشل إرسال الحل (HTTP %s)"
  ; submission_created= "تم إنشاء الإرسال رقم %s. في انتظار التقييم..."
  ; submission_queued= "الإرسال في قائمة الانتظار..."
  ; submission_status_polling= "الحالة: %s (يُتحقق منها كل ثانية)"
  ; submission_done= "اكتمل: %s"
  ; submission_final_verdict= "النتيجة النهائية: %s"
  ; submission_status_accepted= "مقبول"
  ; submission_status_wrong_answer= "إجابة خاطئة"
  ; submission_status_runtime_error= "خطأ أثناء التشغيل"
  ; submission_status_time_limit_exceeded= "تجاوز الحد الزمني"
  ; submission_status_memory_limit_exceeded= "تجاوز حد الذاكرة"
  ; submission_status_compilation_error= "خطأ في الترجمة"
  ; submission_status_presentation_error= "خطأ في التنسيق"
  ; submission_status_internal_error= "خطأ داخلي"
  ; submission_status_pending= "قيد الانتظار"
  ; submission_status_queued= "في قائمة الانتظار"
  ; submission_status_running= "قيد التشغيل"
  ; submission_processing= "جارٍ معالجة حلّك... (الاستعلام كل ثانيتين)"
  ; submission_result= "النتيجة:"
  ; submission_view_results= "عرض النتائج"
  ; submission_view_errors= "عرض الأخطاء"
  ; submission_view_source= "عرض المصدر المرسل"
  ; modal_close= "إغلاق"
  ; codebar_run= "تشغيل الكود"
  ; codebar_confirm_run= "هل تريد تشغيل الكود '%s'?"
  ; modal_cancel= "إلغاء"
  ; modal_confirm= "تأكيد"
  ; problem_submit_solution= "قدم حلك أدناه."
  ; problem_time_limit= "الوقت المحدد"
  ; problem_memory_limit= "حد الذاكرة"
  ; problem_description= "الوصف"
  ; problem_input= "الإدخال"
  ; problem_output= "المخرج"
  ; problem_not_found= "المشكلة غير موجودة"
  ; problem_submit_btn= "إرسال"
  ; subform_placeholder_source= "الكود المصدري"
  ; subform_label_language= "اللغة:"
  ; subform_label_source= "الكود المصدري:"
  ; subform_submit= "إرسال"
  ; submissions_col_id= "#"
  ; submissions_col_owner= "المالك"
  ; submissions_col_problem= "المشكلة"
  ; submissions_col_language= "اللغة"
  ; submissions_col_result= "النتيجة"
  ; submissions_col_time= "الوقت"
  ; submissions_col_date= "التاريخ"
  ; submissions_col_action= "الإجراء"
  ; submissions_reevaluate= "إعادة تقييم"
  ; submissions_recent_title= "الإرسالات الأخيرة"
  ; submissions_show_more= "عرض المزيد"
  ; submissions_loading= "جارٍ تحميل الإرسالات..."
  ; submissions_only_mine= "إرسالياتي فقط"
  ; contests_title= "المسابقات"
  ; problems_col_id= "المعرّف"
  ; problems_col_name= "المشكلة"
  ; problems_title= "المشاكل"
  ; settings_title= "الإعدادات"
  ; settings_theme_label= "السمة"
  ; settings_theme_desc= "اختر سمة لون المحرر."
  ; settings_font_size_label= "حجم الخط"
  ; settings_font_size_desc= "اضبط حجم خط المحرر."
  ; settings_tab_size_label= "حجم المسافة البادئة"
  ; settings_tab_size_desc= "عدد المسافات لكل مسافة بادئة."
  ; settings_wrap_lines= "تغليف الأسطر الطويلة في المحرر."
  ; settings_auto_save= "حفظ الكود تلقائياً أثناء الكتابة."
  ; settings_save_btn= "حفظ"
  ; settings_reset_btn= "إعادة تعيين"
  ; settings_language_label= "اللغة"
  ; settings_import_zip_description=
      "حدد ملف ZIP لاستيراد المشاكل. سيتم إنشاء مشاكل جديدة من محتوى ملف \
       ZIP."
  ; settings_import_zip_button= "استيراد المشاكل"
  ; settings_import_zip_card_title= "استيراد المشاكل"
  ; config_editor_title= "محرر التكوين"
  ; config_history_title= "سجل التكوين"
  ; config_col_version= "الإصدار"
  ; config_col_timestamp= "الطابع الزمني"
  ; config_col_changed_by= "تم التغيير بواسطة"
  ; config_col_action= "الإجراء"
  ; config_col_langs= "اللغات"
  ; config_loading_history= "جاري تحميل السجل..."
  ; settings_appearance_title= "المظهر"
  ; settings_editor_title= "المحرر"
  ; settings_behavior_title= "السلوك"
  ; settings_tab_general= "عام"
  ; settings_tab_password= "كلمة المرور"
  ; settings_tab_yodac= "يوداك"
  ; settings_tab_users= "المستخدمون"
  ; settings_tab_problems= "المشاكل"
  ; settings_llm_evaluation= "تقييم النموذج اللغوي"
  ; settings_line_wrap_label= "تغليف الأسطر"
  ; settings_auto_save_label= "حفظ تلقائي"
  ; settings_admin_badge= "وصول المسؤول"
  ; settings_judge_badge= "وصول القاضي"
  ; password_change_title= "تغيير كلمة المرور"
  ; password_change_description= "حدّث كلمة مرور حسابك."
  ; password_current_label= "كلمة المرور الحالية"
  ; password_new_label= "كلمة المرور الجديدة"
  ; password_confirm_label= "تأكيد كلمة المرور الجديدة"
  ; password_change_submit= "تغيير كلمة المرور"
  ; password_validation_required= "جميع حقول كلمة المرور مطلوبة."
  ; password_validation_mismatch= "كلمتا المرور الجديدتان غير متطابقتين."
  ; password_validation_same= "يجب أن تختلف كلمة المرور الجديدة عن الحالية."
  ; password_notice_updated= "تم تغيير كلمة المرور بنجاح."
  ; password_error_current= "كلمة المرور الحالية غير صحيحة."
  ; password_error_update= "تعذر تغيير كلمة المرور."
  ; config_meta_version= "الإصدار: %s"
  ; config_meta_updated= "المحدّث: %s"
  ; config_meta_by= "بواسطة: %s"
  ; config_total_entries= "إجمالي الإدخالات: %s"
  ; config_no_history= "لا يوجد سجل"
  ; config_save_no_changes= "لا توجد تغييرات للحفظ."
  ; config_edit_btn= "تحرير"
  ; config_cancel_edit_btn= "إلغاء"
  ; progress_status_label= "الحالة: "
  ; progress_time_left_label= "الوقت المتبقي: "
  ; progress_progress_label= "التقدم"
  ; progress_title= "تقدم المسابقة"
  ; problem_progress_title= "تقدم المسألة"
  ; problem_progress_open= "مفتوح"
  ; problem_progress_upcoming= "قادم"
  ; problem_progress_closed= "مغلق"
  ; test_type_text= "نص"
  ; test_type_json= "JSON"
  ; test_invalid_json= "JSON غير صالح"
  ; dropdown_select_problem= "-- اختر مشكلة --"
  ; sidebar_dashboard= "لوحة القيادة"
  ; sidebar_codeboard= "لوحة الكود"
  ; sidebar_submissions= "الإرسالات"
  ; sidebar_switch_contest= "تبديل المسابقة"
  ; sidebar_settings= "الإعدادات"
  ; sidebar_sign_out= "تسجيل الخروج"
  ; login_sign_out= "تسجيل الخروج"
  ; users_manage_title= "إدارة المستخدمين"
  ; users_manage_subtitle= "أنشئ الحسابات وعدل الأدوار مباشرة من هذا الجدول."
  ; users_loading= "جارٍ تحميل المستخدمين..."
  ; users_refresh_btn= "تحديث"
  ; users_create_title= "إضافة مستخدم جديد"
  ; users_create_username_placeholder= "اسم المستخدم"
  ; users_create_password= "كلمة المرور"
  ; users_create_password_placeholder= "كلمة مرور مؤقتة"
  ; users_groups_placeholder= "المجموعة-a، المجموعة-b"
  ; users_create_submit= "إنشاء مستخدم"
  ; users_col_id= "المعرّف"
  ; users_col_username= "اسم المستخدم"
  ; users_col_role= "الدور"
  ; users_col_groups= "المجموعات"
  ; users_col_created_at= "تاريخ الإنشاء"
  ; users_col_last_seen_at= "آخر ظهور"
  ; users_col_actions= "الإجراءات"
  ; users_select_all= "تحديد الكل"
  ; users_delete_selected_btn= "حذف المحدد (%s)"
  ; users_delete_confirm= "حذف %s من المستخدمين المحددين؟"
  ; users_delete_failed= "فشل حذف %s من المستخدمين المحددين."
  ; users_notice_deleted= "تم حذف المستخدمين المحددين بنجاح."
  ; users_action_edit= "تحرير"
  ; users_action_save= "حفظ"
  ; users_action_cancel= "إلغاء"
  ; users_notice_created= "تم إنشاء المستخدم بنجاح."
  ; users_notice_updated= "تم تحديث المستخدم بنجاح."
  ; users_validation_required=
      "اسم المستخدم وكلمة المرور مطلوبان لإنشاء مستخدم جديد."
  ; users_import_in_progress= "جارٍ استيراد المستخدمين..."
  ; users_import_summary= "اكتمل الاستيراد: تم إنشاء %s مستخدمين، و%s أخطاء."
  ; users_import_invalid_header=
      "رأس CSV غير صالح. المتوقع: username,password,role,groups"
  ; users_import_invalid_row= "صف CSV غير صالح في السطر"
  ; users_import_invalid_role= "دور غير صالح في السطر"
  ; users_import_read_failed= "فشل في قراءة ملف CSV المحدد."
  ; users_import_input_missing= "حقل ملف الاستيراد غير متوفر في هذه الصفحة."
  ; users_import_empty_file= "ملف CSV المحدد فارغ."
  ; users_import_btn= "استيراد المستخدمين"
  ; settings_tab_stats= "الإحصاءات"
  ; stats_loading= "جارٍ تحميل الإحصاءات..."
  ; stats_empty= "لا توجد إحصاءات متاحة."
  ; stats_refresh_btn= "تحديث"
  ; stats_error_prefix= "تعذر تحميل الإحصاءات (HTTP %s)"
  ; stats_parse_error= "تعذر تحليل الإحصاءات: %s"
  ; stats_yodab_info= "معلومات YodaB"
  ; stats_yodab= "مقاييس YodaB"
  ; stats_yodac= "مقاييس YodaC"
  ; stats_api_version= "إصدار API"
  ; stats_yoda_version= "إصدار Yoda"
  ; stats_contributors= "قائمة المساهمين"
  ; stats_requests_total= "إجمالي الطلبات"
  ; stats_requests_per_minute= "الطلبات في الدقيقة"
  ; stats_submissions_total= "إجمالي الإرسالات"
  ; stats_submissions_per_minute= "الإرسالات في الدقيقة"
  ; stats_queued_jobs_total= "المهام في الطابور"
  ; stats_queued_jobs_per_minute= "المهام في الطابور لكل دقيقة"
  ; stats_processed_jobs_total= "إجمالي المهام المعالجة"
  ; stats_processed_jobs_per_minute= "المهام المعالجة لكل دقيقة"
  ; problems_manage_title= "إدارة المشاكل"
  ; problems_manage_subtitle= "أضف أو حرر أو احذف المشاكل وحالات الاختبار."
  ; problems_loading= "جارٍ تحميل المشاكل..."
  ; problems_search_placeholder= "البحث عن المشاكل..."
  ; problems_select_contest= "تحديد المسابقة"
  ; problems_no_contest= "لم يتم تحديد أي مسابقة"
  ; problems_add_btn= "إضافة مشكلة"
  ; problems_add_title= "إضافة مشكلة جديدة"
  ; problems_edit_title= "تحرير المشكلة"
  ; problems_code_label= "الرمز"
  ; problems_title_label= "العنوان"
  ; problems_difficulty_label= "الصعوبة"
  ; problems_time_limit_label= "الحد الزمني (مللي ثانية)"
  ; problems_memory_limit_label= "حد الذاكرة (ميغابايت)"
  ; problems_languages_label= "اللغات"
  ; problems_disable_submissions_label= "تعطيل الإرسالات"
  ; problems_force_closed_label= "إغلاق إجباري"
  ; problems_description_label= "الوصف"
  ; problems_input_spec_label= "مواصفات الإدخال"
  ; problems_output_spec_label= "مواصفات الإخراج"
  ; problems_cancel_btn= "إلغاء"
  ; problems_submit_btn= "إرسال"
  ; problems_save_changes= "حفظ التغييرات"
  ; problems_delete_confirm= "هل تريد حذف هذه المشكلة؟"
  ; problems_testcases_title= "حالات الاختبار"
  ; problems_add_testcase= "إضافة حالة اختبار"
  ; problems_test_input_label= "الإدخال"
  ; problems_test_output_label= "الإخراج"
  ; problems_is_sample_label= "عينة"
  ; problems_edit_testcase= "تحرير حالة الاختبار"
  ; problems_delete_testcase= "هل تريد حذف حالة الاختبار؟"
  ; problems_easy= "سهل"
  ; problems_medium= "متوسط"
  ; problems_hard= "صعب"
  ; problems_error_load= "تعذر تحميل المشاكل: %s"
  ; problems_error_save= "تعذر حفظ المشكلة: %s"
  ; problems_error_delete= "تعذر حذف المشكلة."
  ; problems_success_created= "تم إنشاء المشكلة."
  ; problems_success_updated= "تم تحديث المشكلة."
  ; problems_success_deleted= "تم حذف المشكلة."
  ; problems_confirm_delete= "تأكيد الحذف" }

let map : translations -> (string, string) Hashtbl.t =
 fun tr ->
  let h = Hashtbl.create 55 in
  let add k v = Hashtbl.add h k v in
  add "login_placeholder_email" tr.login_placeholder_email ;
  add "login_placeholder_password" tr.login_placeholder_password ;
  add "login_sign_in" tr.login_sign_in ;
  add "login_title" tr.login_title ;
  add "login_label_email" tr.login_label_email ;
  add "login_label_password" tr.login_label_password ;
  add "login_remember_me" tr.login_remember_me ;
  add "login_session_expired" tr.login_session_expired ;
  add "login_footer" tr.login_footer ;
  add "sidebar_app_name" tr.sidebar_app_name ;
  add "status_checking_title" tr.status_checking_title ;
  add "status_checking_description" tr.status_checking_description ;
  add "status_maintenance_title" tr.status_maintenance_title ;
  add "status_maintenance_description" tr.status_maintenance_description ;
  add "status_unavailable_title" tr.status_unavailable_title ;
  add "status_unavailable_description" tr.status_unavailable_description ;
  add "status_retry_countdown" tr.status_retry_countdown ;
  add "status_retrying" tr.status_retrying ;
  add "tabbar_actions_label" tr.tabbar_actions_label ;
  add "tabbar_download_title" tr.tabbar_download_title ;
  add "tabbar_copy" tr.tabbar_copy ;
  add "tabbar_copy_title" tr.tabbar_copy_title ;
  add "tabbar_confirm_skeleton" tr.tabbar_confirm_skeleton ;
  add "tabbar_skeleton" tr.tabbar_skeleton ;
  add "tabbar_set_skeleton_title" tr.tabbar_set_skeleton_title ;
  add "codebar_all_changes_saved" tr.codebar_all_changes_saved ;
  add "codebar_saving" tr.codebar_saving ;
  add "codebar_auto_save_disabled" tr.codebar_auto_save_disabled ;
  add "spinner_modal_processing" tr.spinner_modal_processing ;
  add "spinner_modal_ready" tr.spinner_modal_ready ;
  add "codebar_local_run" tr.codebar_local_run ;
  add "codebar_evaluate" tr.codebar_evaluate ;
  add "codebar_confirm_save" tr.codebar_confirm_save ;
  add "codebar_evaluate_save" tr.codebar_evaluate_save ;
  add "codebar_run" tr.codebar_run ;
  add "codebar_confirm_run" tr.codebar_confirm_run ;
  add "modal_cancel" tr.modal_cancel ;
  add "modal_confirm" tr.modal_confirm ;
  add "modal_confirm_action" tr.modal_confirm_action ;
  add "submission_sending" tr.submission_sending ;
  add "submission_problem_check_failed" tr.submission_problem_check_failed ;
  add "submission_problem_force_closed" tr.submission_problem_force_closed ;
  add "submission_no_problem" tr.submission_no_problem ;
  add "submission_no_language" tr.submission_no_language ;
  add "submission_empty_editor" tr.submission_empty_editor ;
  add "submission_preparing" tr.submission_preparing ;
  add "submission_history" tr.submission_history ;
  add "submission_cannot_submit" tr.submission_cannot_submit ;
  add "submission_sending_language" tr.submission_sending_language ;
  add "submission_failed_http" tr.submission_failed_http ;
  add "submission_created" tr.submission_created ;
  add "submission_queued" tr.submission_queued ;
  add "submission_status_polling" tr.submission_status_polling ;
  add "submission_done" tr.submission_done ;
  add "submission_final_verdict" tr.submission_final_verdict ;
  add "submission_status_accepted" tr.submission_status_accepted ;
  add "submission_status_wrong_answer" tr.submission_status_wrong_answer ;
  add "submission_status_runtime_error" tr.submission_status_runtime_error ;
  add "submission_status_time_limit_exceeded"
    tr.submission_status_time_limit_exceeded ;
  add "submission_status_memory_limit_exceeded"
    tr.submission_status_memory_limit_exceeded ;
  add "submission_status_compilation_error"
    tr.submission_status_compilation_error ;
  add "submission_status_presentation_error"
    tr.submission_status_presentation_error ;
  add "submission_status_internal_error" tr.submission_status_internal_error ;
  add "submission_status_pending" tr.submission_status_pending ;
  add "submission_status_queued" tr.submission_status_queued ;
  add "submission_status_running" tr.submission_status_running ;
  add "submission_processing" tr.submission_processing ;
  add "submission_result" tr.submission_result ;
  add "submission_view_results" tr.submission_view_results ;
  add "submission_view_errors" tr.submission_view_errors ;
  add "submission_view_source" tr.submission_view_source ;
  add "modal_close" tr.modal_close ;
  add "problem_submit_solution" tr.problem_submit_solution ;
  add "problem_time_limit" tr.problem_time_limit ;
  add "problem_memory_limit" tr.problem_memory_limit ;
  add "problem_description" tr.problem_description ;
  add "problem_input" tr.problem_input ;
  add "problem_output" tr.problem_output ;
  add "problem_not_found" tr.problem_not_found ;
  add "problem_submit_btn" tr.problem_submit_btn ;
  add "subform_placeholder_source" tr.subform_placeholder_source ;
  add "subform_label_language" tr.subform_label_language ;
  add "subform_label_source" tr.subform_label_source ;
  add "subform_submit" tr.subform_submit ;
  add "submissions_col_id" tr.submissions_col_id ;
  add "submissions_col_owner" tr.submissions_col_owner ;
  add "submissions_col_problem" tr.submissions_col_problem ;
  add "submissions_col_language" tr.submissions_col_language ;
  add "submissions_col_result" tr.submissions_col_result ;
  add "submissions_col_time" tr.submissions_col_time ;
  add "submissions_col_date" tr.submissions_col_date ;
  add "submissions_col_action" tr.submissions_col_action ;
  add "submissions_reevaluate" tr.submissions_reevaluate ;
  add "submissions_recent_title" tr.submissions_recent_title ;
  add "submissions_show_more" tr.submissions_show_more ;
  add "submissions_loading" tr.submissions_loading ;
  add "submissions_only_mine" tr.submissions_only_mine ;
  add "contests_title" tr.contests_title ;
  add "problems_col_id" tr.problems_col_id ;
  add "problems_col_name" tr.problems_col_name ;
  add "problems_title" tr.problems_title ;
  add "settings_title" tr.settings_title ;
  add "settings_theme_label" tr.settings_theme_label ;
  add "settings_theme_desc" tr.settings_theme_desc ;
  add "settings_font_size_label" tr.settings_font_size_label ;
  add "settings_font_size_desc" tr.settings_font_size_desc ;
  add "settings_tab_size_label" tr.settings_tab_size_label ;
  add "settings_tab_size_desc" tr.settings_tab_size_desc ;
  add "settings_wrap_lines" tr.settings_wrap_lines ;
  add "settings_auto_save" tr.settings_auto_save ;
  add "settings_save_btn" tr.settings_save_btn ;
  add "settings_reset_btn" tr.settings_reset_btn ;
  add "settings_language_label" tr.settings_language_label ;
  add "settings_import_zip_description" tr.settings_import_zip_description ;
  add "settings_import_zip_button" tr.settings_import_zip_button ;
  add "settings_import_zip_card_title" tr.settings_import_zip_card_title ;
  add "config_editor_title" tr.config_editor_title ;
  add "config_history_title" tr.config_history_title ;
  add "config_col_version" tr.config_col_version ;
  add "config_col_timestamp" tr.config_col_timestamp ;
  add "config_col_changed_by" tr.config_col_changed_by ;
  add "config_col_action" tr.config_col_action ;
  add "config_col_langs" tr.config_col_langs ;
  add "config_loading_history" tr.config_loading_history ;
  add "settings_appearance_title" tr.settings_appearance_title ;
  add "settings_editor_title" tr.settings_editor_title ;
  add "settings_behavior_title" tr.settings_behavior_title ;
  add "settings_tab_general" tr.settings_tab_general ;
  add "settings_tab_password" tr.settings_tab_password ;
  add "settings_tab_yodac" tr.settings_tab_yodac ;
  add "settings_tab_users" tr.settings_tab_users ;
  add "settings_tab_problems" tr.settings_tab_problems ;
  add "settings_llm_evaluation" tr.settings_llm_evaluation ;
  add "settings_line_wrap_label" tr.settings_line_wrap_label ;
  add "settings_auto_save_label" tr.settings_auto_save_label ;
  add "settings_admin_badge" tr.settings_admin_badge ;
  add "settings_judge_badge" tr.settings_judge_badge ;
  add "password_change_title" tr.password_change_title ;
  add "password_change_description" tr.password_change_description ;
  add "password_current_label" tr.password_current_label ;
  add "password_new_label" tr.password_new_label ;
  add "password_confirm_label" tr.password_confirm_label ;
  add "password_change_submit" tr.password_change_submit ;
  add "password_validation_required" tr.password_validation_required ;
  add "password_validation_mismatch" tr.password_validation_mismatch ;
  add "password_validation_same" tr.password_validation_same ;
  add "password_notice_updated" tr.password_notice_updated ;
  add "password_error_current" tr.password_error_current ;
  add "password_error_update" tr.password_error_update ;
  add "config_meta_version" tr.config_meta_version ;
  add "config_meta_updated" tr.config_meta_updated ;
  add "config_meta_by" tr.config_meta_by ;
  add "config_total_entries" tr.config_total_entries ;
  add "config_no_history" tr.config_no_history ;
  add "config_save_no_changes" tr.config_save_no_changes ;
  add "config_edit_btn" tr.config_edit_btn ;
  add "config_cancel_edit_btn" tr.config_cancel_edit_btn ;
  add "progress_status_label" tr.progress_status_label ;
  add "progress_time_left_label" tr.progress_time_left_label ;
  add "progress_progress_label" tr.progress_progress_label ;
  add "progress_title" tr.progress_title ;
  add "problem_progress_title" tr.problem_progress_title ;
  add "problem_progress_open" tr.problem_progress_open ;
  add "problem_progress_upcoming" tr.problem_progress_upcoming ;
  add "problem_progress_closed" tr.problem_progress_closed ;
  add "test_type_text" tr.test_type_text ;
  add "test_type_json" tr.test_type_json ;
  add "test_invalid_json" tr.test_invalid_json ;
  add "dropdown_select_problem" tr.dropdown_select_problem ;
  add "sidebar_dashboard" tr.sidebar_dashboard ;
  add "sidebar_codeboard" tr.sidebar_codeboard ;
  add "sidebar_submissions" tr.sidebar_submissions ;
  add "sidebar_switch_contest" tr.sidebar_switch_contest ;
  add "sidebar_settings" tr.sidebar_settings ;
  add "sidebar_sign_out" tr.sidebar_sign_out ;
  add "login_sign_out" tr.login_sign_out ;
  add "users_manage_title" tr.users_manage_title ;
  add "users_manage_subtitle" tr.users_manage_subtitle ;
  add "users_loading" tr.users_loading ;
  add "users_refresh_btn" tr.users_refresh_btn ;
  add "users_create_title" tr.users_create_title ;
  add "users_create_username_placeholder"
    tr.users_create_username_placeholder ;
  add "users_create_password" tr.users_create_password ;
  add "users_create_password_placeholder"
    tr.users_create_password_placeholder ;
  add "users_groups_placeholder" tr.users_groups_placeholder ;
  add "users_create_submit" tr.users_create_submit ;
  add "users_col_id" tr.users_col_id ;
  add "users_col_username" tr.users_col_username ;
  add "users_col_role" tr.users_col_role ;
  add "users_col_groups" tr.users_col_groups ;
  add "users_col_created_at" tr.users_col_created_at ;
  add "users_col_last_seen_at" tr.users_col_last_seen_at ;
  add "users_col_actions" tr.users_col_actions ;
  add "users_select_all" tr.users_select_all ;
  add "users_delete_selected_btn" tr.users_delete_selected_btn ;
  add "users_delete_confirm" tr.users_delete_confirm ;
  add "users_delete_failed" tr.users_delete_failed ;
  add "users_notice_deleted" tr.users_notice_deleted ;
  add "users_action_edit" tr.users_action_edit ;
  add "users_action_save" tr.users_action_save ;
  add "users_action_cancel" tr.users_action_cancel ;
  add "users_notice_created" tr.users_notice_created ;
  add "users_notice_updated" tr.users_notice_updated ;
  add "users_validation_required" tr.users_validation_required ;
  add "users_import_in_progress" tr.users_import_in_progress ;
  add "users_import_summary" tr.users_import_summary ;
  add "users_import_invalid_header" tr.users_import_invalid_header ;
  add "users_import_invalid_row" tr.users_import_invalid_row ;
  add "users_import_invalid_role" tr.users_import_invalid_role ;
  add "users_import_read_failed" tr.users_import_read_failed ;
  add "users_import_input_missing" tr.users_import_input_missing ;
  add "users_import_empty_file" tr.users_import_empty_file ;
  add "users_import_btn" tr.users_import_btn ;
  add "settings_tab_stats" tr.settings_tab_stats ;
  add "stats_loading" tr.stats_loading ;
  add "stats_empty" tr.stats_empty ;
  add "stats_refresh_btn" tr.stats_refresh_btn ;
  add "stats_error_prefix" tr.stats_error_prefix ;
  add "stats_parse_error" tr.stats_parse_error ;
  add "stats_yodab_info" tr.stats_yodab_info ;
  add "stats_yodab" tr.stats_yodab ;
  add "stats_yodac" tr.stats_yodac ;
  add "stats_api_version" tr.stats_api_version ;
  add "stats_yoda_version" tr.stats_yoda_version ;
  add "stats_contributors" tr.stats_contributors ;
  add "stats_requests_total" tr.stats_requests_total ;
  add "stats_requests_per_minute" tr.stats_requests_per_minute ;
  add "stats_submissions_total" tr.stats_submissions_total ;
  add "stats_submissions_per_minute" tr.stats_submissions_per_minute ;
  add "stats_queued_jobs_total" tr.stats_queued_jobs_total ;
  add "stats_queued_jobs_per_minute" tr.stats_queued_jobs_per_minute ;
  add "stats_processed_jobs_total" tr.stats_processed_jobs_total ;
  add "stats_processed_jobs_per_minute" tr.stats_processed_jobs_per_minute ;
  add "problems_manage_title" tr.problems_manage_title ;
  add "problems_manage_subtitle" tr.problems_manage_subtitle ;
  add "problems_loading" tr.problems_loading ;
  add "problems_search_placeholder" tr.problems_search_placeholder ;
  add "problems_select_contest" tr.problems_select_contest ;
  add "problems_no_contest" tr.problems_no_contest ;
  add "problems_add_btn" tr.problems_add_btn ;
  add "problems_add_title" tr.problems_add_title ;
  add "problems_edit_title" tr.problems_edit_title ;
  add "problems_code_label" tr.problems_code_label ;
  add "problems_title_label" tr.problems_title_label ;
  add "problems_difficulty_label" tr.problems_difficulty_label ;
  add "problems_time_limit_label" tr.problems_time_limit_label ;
  add "problems_memory_limit_label" tr.problems_memory_limit_label ;
  add "problems_languages_label" tr.problems_languages_label ;
  add "problems_disable_submissions_label"
    tr.problems_disable_submissions_label ;
  add "problems_force_closed_label" tr.problems_force_closed_label ;
  add "problems_description_label" tr.problems_description_label ;
  add "problems_input_spec_label" tr.problems_input_spec_label ;
  add "problems_output_spec_label" tr.problems_output_spec_label ;
  add "problems_cancel_btn" tr.problems_cancel_btn ;
  add "problems_submit_btn" tr.problems_submit_btn ;
  add "problems_save_changes" tr.problems_save_changes ;
  add "problems_delete_confirm" tr.problems_delete_confirm ;
  add "problems_testcases_title" tr.problems_testcases_title ;
  add "problems_add_testcase" tr.problems_add_testcase ;
  add "problems_test_input_label" tr.problems_test_input_label ;
  add "problems_test_output_label" tr.problems_test_output_label ;
  add "problems_is_sample_label" tr.problems_is_sample_label ;
  add "problems_edit_testcase" tr.problems_edit_testcase ;
  add "problems_delete_testcase" tr.problems_delete_testcase ;
  add "problems_easy" tr.problems_easy ;
  add "problems_medium" tr.problems_medium ;
  add "problems_hard" tr.problems_hard ;
  h
