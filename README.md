# ErikaLegacyDownloader
Downloads attachments from an airtable csv

Run the exe or ahk script if you have autohotkey installed.

Export the `Testimonials` Grid View from airtable.

Place the exported `Testimonials-Grid view.csv` in the same folder as the exe/ahk.

Run the ahk script or the exe.

Click download.

All entries with attachments should have their attachements downloaded in `attachements/{Name}/{...attachements}`

All entires that are processed will be moved into `master.csv` which will be created automatically, and these entires will not have the attachment column

