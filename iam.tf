resource "google_project_iam_policy" "security-automation-iam" {
  project     = "security-automation-414205"
  policy_data = data.google_iam_policy.admin.policy_data
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/owner"

    members = [
      "user:mezaneus@gmail.com",
    ]
  }
}

# IAM conditions for limited-time users e.g External

resource "google_project_iam_policy" "security-automation-iam-external" {
  project     = "security-automation-414205"
  policy_data = "${data.google_iam_policy.admin.policy_data}"
}

data "google_iam_policy" "external-users" {
  binding {
    role = "roles/compute.admin"

    members = [
      "user:johndoe@example.com",
    ]

    # Add other users as required

    condition {
      title       = "expires_after_2024_12_31"
      description = "Expiring at midnight of 2024-12-31"
      expression  = "request.time < timestamp(\"2025-01-01T00:00:00Z\")"
    }
  }
}

resource "google_project_iam_binding" "prevent_privilege_escalation" {
  project = "security-automation-414205"
  role    = "roles/editor"

  members = [
    "user:johndoe@example.com",
    "serviceAccount:security-automation-acc@security-automation-414205.iam.gserviceaccount.com",
    # Add other users and service accounts as needed for editor role
  ]
}
