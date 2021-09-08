# -*- mode: makefile; -*-

perlcritic = @PERLCRITIC@

PERLCRITIC_THEME = 'security||certrule||freenode'
PERLCRITIC_SEVERITY = 1
PERLCRITIC_VERBOSITY = 9
PERLCRITICRC = $(top_srcdir)/perlcriticrc

PERLCRITIC_OPTIONS = \
    --profile $(PERLCRITICRC) \
    --force \
    --theme $(PERLCRITIC_THEME) \
    --severity $(PERLCRITIC_SEVERITY) \
    --verbose $(PERLCRITIC_VERBOSITY)

if PERLCRITIC_MODE_ENABLED
check: $(PERLCRITIC_MODULES)
	set -o pipefail; \
	ERRORS=$$(mktemp); \
	for p in $(PERLCRITIC_MODULES); do \
	  LOGFILE="$$p.log"; \
	  if ! $(perlcritic) $(PERLCRITIC_OPTIONS) $$p 2>&1 | tee $$LOGFILE; then \
	    echo $$p>>$$ERRORS; \
	  fi; \
	done; \
	if test -s "$$ERRORS"; then \
	  echo "perlcritic errors in files: "; \
	  cat $$ERRORS; \
	  exit 1; \
	fi
endif
