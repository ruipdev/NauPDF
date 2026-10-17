{{/*
Expand the name of the naupdf
*/}}
{{- define "naupdf.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "naupdf.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "naupdf.labels" -}}
helm.sh/chart: {{ include "naupdf.chart" . }}
{{ include "naupdf.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "naupdf.selectorLabels" -}}
app.kubernetes.io/name: {{ include "naupdf.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
