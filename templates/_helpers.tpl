{{/*
Expand the name of the chart.
*/}}
{{- define "ai-homelab.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ai-homelab.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ai-homelab.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ai-homelab.labels" -}}
helm.sh/chart: {{ include "ai-homelab.chart" . }}
{{ include "ai-homelab.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ai-homelab.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ai-homelab.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create service name for a specific service
*/}}
{{- define "ai-homelab.serviceName" -}}
{{- printf "%s-%s" (include "ai-homelab.fullname" .) .serviceName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create configmap name for a specific service
*/}}
{{- define "ai-homelab.configMapName" -}}
{{- printf "%s-%s-config" (include "ai-homelab.fullname" .) .serviceName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create secret name for a specific service
*/}}
{{- define "ai-homelab.secretName" -}}
{{- printf "%s-%s-secret" (include "ai-homelab.fullname" .) .serviceName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create deployment name for a specific service
*/}}
{{- define "ai-homelab.deploymentName" -}}
{{- printf "%s-%s" (include "ai-homelab.fullname" .) .serviceName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create service account name for a specific service
*/}}
{{- define "ai-homelab.serviceAccountName" -}}
{{- printf "%s-%s" (include "ai-homelab.fullname" .) .serviceName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create Ollama service DNS name with fallback handling
*/}}
{{- define "ai-homelab.ollamaServiceDNS" -}}
{{- $serviceName := printf "%s-ollama" (include "ai-homelab.fullname" .) -}}
{{- if .Values.ollama.service.dns.useFQDN -}}
{{- $namespace := default .Release.Namespace .Values.ollama.service.dns.namespace -}}
{{- $clusterDomain := default "cluster.local" .Values.ollama.service.dns.clusterDomain -}}
{{- printf "%s.%s.svc.%s" $serviceName $namespace $clusterDomain -}}
{{- else -}}
{{- $serviceName -}}
{{- end -}}
{{- end }}