Runtime bundle for Linux x86_64 (x86_64-unknown-linux-gnu).

Run ./Run.sh after extracting the archive. On first run, provide your WhatsApp phone number; this creates .env. Pairing details are printed in the terminal.

This bundle includes the bot, Deno, and the latest yt-dlp release at packaging time: 2026.10.26 for Linux x86_64. Run.sh uses the bundled yt-dlp. To substitute another executable, replace libraries/yt-dlp or set YTDLP_BINARY=/absolute/path/to/yt-dlp when running ./Run.sh.

For YouTube bot verification, set YOUTUBE_COOKIES_FILE in .env to a Netscape-format cookies file. Cookies and account session files are private and are not included.

Video download throughput is limited by default to 3 MiB/s to reduce CPU spikes on constrained hosts. Change YOUTUBE_DOWNLOAD_LIMIT_MIB_S in .env to a lower value for lower load or a higher value for faster downloads. Lower throughput may reduce CPU use but increases download time.

Requires Linux x86_64 with glibc and Python 3 for first-run phone-number setup.
