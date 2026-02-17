{{- define "repo-test-infra-front.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "repo-test-infra-front.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- include "repo-test-infra-front.name" . | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "repo-test-infra-front.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "repo-test-infra-front.labels" -}}
helm.sh/chart: {{ include "repo-test-infra-front.chart" . }}
{{ include "repo-test-infra-front.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "repo-test-infra-front.selectorLabels" -}}
app.kubernetes.io/name: {{ include "repo-test-infra-front.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "repo-test-infra-front.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "repo-test-infra-front.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}