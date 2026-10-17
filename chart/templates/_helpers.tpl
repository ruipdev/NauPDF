{{/*
Expand the name of the PDF8
*/}}
{{- define "pdf8.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pdf8.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pdf8.labels" -}}
helm.sh/chart: {{ include "pdf8.chart" . }}
{{ include "pdf8.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pdf8.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pdf8.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
