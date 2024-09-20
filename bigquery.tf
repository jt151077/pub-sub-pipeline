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

resource "google_bigquery_dataset" "gbq_dataset" {
  depends_on = [
    google_project_service.gcp_services
  ]
  project       = local.project_id
  dataset_id    = "technology_playground_platform"
  friendly_name = "technology_playground_platform"
  location      = local.project_default_region
}


resource "google_bigquery_table" "gbq_table" {
  depends_on = [
    google_bigquery_dataset.gbq_dataset
  ]
  project             = local.project_id
  dataset_id          = google_bigquery_dataset.gbq_dataset.dataset_id
  table_id            = "devops_log_poc"
  deletion_protection = false

  schema = <<EOF
[
  {
    "description": "",
    "type": "STRING",
    "name": "data",
    "mode": "NULLABLE"
  },
  {
    "description": "",
    "type": "STRING",
    "name": "subscription_name",
    "mode": "NULLABLE"
  },
  {
    "description": "",
    "type": "STRING",
    "name": "message_id",
    "mode": "NULLABLE"
  },
  {
    "description": "",
    "type": "TIMESTAMP",
    "name": "publish_time",
    "mode": "NULLABLE"
  },
  {
    "description": "",
    "type": "STRING",
    "name": "attributes",
    "mode": "NULLABLE"
  }
]
EOF
}
