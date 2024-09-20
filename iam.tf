/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  roles = [
    "roles/bigquery.metadataViewer",
    "roles/bigquery.dataEditor",
    "roles/pubsub.publisher",
    "roles/pubsub.subscriber"
  ]
}

resource "google_project_iam_member" "pub-sub-role" {
  depends_on = [
    google_project_service.gcp_services
  ]
  for_each = toset(local.roles)
  project  = local.project_id
  role     = each.value
  member   = "serviceAccount:service-${local.project_number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}