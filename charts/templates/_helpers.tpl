{{- define "Repo-test-Infra-Front.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "Repo-test-Infra-Front.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- include "Repo-test-Infra-Front.name" . | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "Repo-test-Infra-Front.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "Repo-test-Infra-Front.labels" -}}
helm.sh/chart: {{ include "Repo-test-Infra-Front.chart" . }}
{{ include "Repo-test-Infra-Front.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "Repo-test-Infra-Front.selectorLabels" -}}
app.kubernetes.io/name: {{ include "Repo-test-Infra-Front.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "Repo-test-Infra-Front.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "Repo-test-Infra-Front.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}