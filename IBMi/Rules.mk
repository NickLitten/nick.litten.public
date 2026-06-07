# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules
# -----------------------------------------------------------------------------
# This file defines build targets and subdirectories for the MAKEi build system.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------
SUBDIRS := \
	.Database \
	.Services \
	ClearBobLogs \
	ClearPfrdata \
	CodeSamples \
	Conversion \
	Debug \
	EmailCsvFile \
	EmailOutq \
	HelloWorld \
	ListLibraries \
	MySqlServer \
	PasswordMonitor \
	StoredProcs \
	SubfileSamples \
	Update_iasp \
	UploadFiles \
	WebServices
