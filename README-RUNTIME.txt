Runtime bundle for Linux x86_64 (x86_64-unknown-linux-gnu).

Run ./Run.sh after extracting the archive. On first run, provide your WhatsApp phone number; this creates .env. Pairing details are printed in the terminal.

This lightweight bundle includes the bot and Deno, but not yt-dlp. Put your x86_64 Linux yt-dlp executable at libraries/yt-dlp, or set YTDLP_BINARY=/absolute/path/to/yt-dlp when running ./Run.sh. Run.sh copies the supplied binary into libraries/yt-dlp if needed.

For YouTube bot verification, set YOUTUBE_COOKIES_FILE in .env to a Netscape-format cookies file. Cookies and account session files are private and are not included.

Requires Linux x86_64 with glibc and Python 3 for first-run phone-number setup.
