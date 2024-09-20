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


resource "google_pubsub_topic" "ingestion-topic" {
  depends_on = [
    google_project_service.gcp_services
  ]

  project = local.project_id
  name    = var.topic_id
}

resource "google_pubsub_topic" "dead-letter-topic" {
  depends_on = [
    google_project_service.gcp_services
  ]

  project = local.project_id
  name    = "${var.topic_id}-DLQ"
}

resource "google_pubsub_subscription" "devops_log_raw_to_bigquery" {
  depends_on = [
    google_pubsub_topic.ingestion-topic,
    google_project_iam_member.pub-sub-role
  ]

  project = local.project_id
  name    = "devops_log_raw_to_bigquery"
  topic   = google_pubsub_topic.ingestion-topic.name

  bigquery_config {
    table            = "${local.project_id}.${google_bigquery_dataset.gbq_dataset.dataset_id}.${google_bigquery_table.gbq_table.table_id}"
    use_table_schema = true
    write_metadata   = true
  }

  dead_letter_policy {
    dead_letter_topic     = "projects/${local.project_id}/topics/${google_pubsub_topic.dead-letter-topic.name}"
    max_delivery_attempts = 5
  }
}