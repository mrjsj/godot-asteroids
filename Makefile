.PHONY: serve

PORT=8000
URL=http://localhost:$(PORT)/build/web

serve:
	@echo "Starting Python web server on port $(PORT)..."
	@python3 build/webserver.py > /dev/null 2>&1 & \
	sleep 1 && \
	echo "Opening browser at $(URL)..." && \
	$(MAKE) open-browser

open-browser:
	@if command -v firefox >/dev/null; then \
		firefox --new-tab $(URL); \
	elif command -v xdg-open >/dev/null; then \
		xdg-open $(URL); \
	elif command -v open >/dev/null; then \
		open $(URL); \
	else \
		echo "Could not detect a browser opener."; \
	fi
