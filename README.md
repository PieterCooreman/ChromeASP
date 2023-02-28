# ChromeASP
Headless Chrome.exe used as a PDF generator in classic ASP/VBScript
## Intro
Classic ASP/VBScript developers never had an easy (and free) way to generate PDF files. This ASP script uses headless Chrome to get the job done.
Some things to keep in mind:

- You need Chrome installed on your PC/Server
- IUSR (or Everyone) needs full permissions on Chrome.exe file
- You have to create a folder on your system where Chrome stores logs/debugs - make sure to give IUSR permissions too
