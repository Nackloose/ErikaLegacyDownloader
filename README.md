# ErikaLegacyDownloader
Downloads attachments from an airtable csv

Run the exe or ahk script if you have autohotkey installed.

Export the `Testimonials` Grid View from airtable.

Place the exported `Testimonials-Grid view.csv` in the same folder as the exe/ahk.

Click download.

All entries with attachments should have their attachements downloaded in `attachements/{Name}/{...attachements}`

All entires that are processed will be moved into `master.csv` which will be created automatically, and these entires will not have the attachment column

After the `Testimonials-Grid view.csv` has been processed, it will be renamed to `Imported-Testimonials-Grid view.csv` automatically as to prevent double importing.
This file can be deleted at your leisure and is left over ***just incase something goes wrong***
