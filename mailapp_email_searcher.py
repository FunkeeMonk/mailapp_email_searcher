#!/usr/bin/python
# Go through emails stored in Apple's Mail.app, looking for unread messages in the 'Sales Report' account, then searches for the first name and mailing address indicated after the BILLING INFORMATION section.

from Foundation import *
from ScriptingBridge import *

def customer_email_from_mail_content(content):
	customer_email = None	
	billing_pos = content.find('BILLING INFORMATION')
	if billing_pos >= 0:
		name_pos = content.find('Name:', billing_pos)
		end_of_name_pos = content.find('\n', name_pos)
		mailto_pos = content.find('mailto:', end_of_name_pos)
		end_of_mail_pos = content.find('\n', mailto_pos)
		customer_email = content[name_pos + 5:end_of_name_pos] + "<" + content[mailto_pos + 7:end_of_mail_pos - 1] + ">"
	return customer_email

mailApp = SBApplication.applicationWithBundleIdentifier_("com.apple.Mail")

i = 0
for account in mailApp.accounts():
	if account.name() == 'Sales Report':
		for mailbox in account.mailboxes():
 			if mailbox.name() == 'INBOX':
				for message in mailbox.messages():
					if message.readStatus() == False:
 						print customer_email_from_mail_content(message.source().encode('latin-1'))
						i = i + 1
				break

print str(i) + " emails found."
