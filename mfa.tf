resource "google_project" "security-automation" {
  project_id = "security-automation-414205"
  name       = "security-automation"
  org_id     = "123456789"
  billing_account =  "000000-0000000-0000000-000000"
  labels = {
    firebase = "enabled"
  }
}

resource "google_project_service" "identitytoolkit" {
  project = google_project.security-automation.project_id
  service = "identitytoolkit.googleapis.com"
}

resource "google_identity_platform_config" "default" {
  project = google_project.security-automation.project_id
  autodelete_anonymous_users = true
  sign_in {
    allow_duplicate_emails = true

    anonymous {
        enabled = true
    }
    email {
        enabled = true
        password_required = false
    }
    phone_number {
        enabled = true
        test_phone_numbers = {
            "+44231231234" = "000000"
        }
    }
  }
  sms_region_config {
    allowlist_only {
        # Select allowed regions
      allowed_regions = [
        "US",
        "CA",
      ]
    }
  }
  blocking_functions {
    triggers {
      event_type = "beforeSignIn"
      function_uri = "https://us-east1-my-project.cloudfunctions.net/before-sign-in"
    }
    forward_inbound_credentials {
      refresh_token = true
      access_token = true
      id_token = true
    }
  }
  quota {
    sign_up_quota_config {
      quota = 1000
      start_time = ""
      quota_duration = "7200s"
    }
  }
#   Sample domains
   authorized_domains = [
    "localhost",
    "my-project.firebaseapp.com",
    "my-project.web.app",
  ]
}
