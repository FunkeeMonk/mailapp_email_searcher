/*
 * Mail.m
 */

#include "Mail.h"




/*
 * Standard Suite
 */

@implementation MailItem


- (NSDictionary *) properties
{
	return [[self propertyWithCode:'pALL'] get];
}

- (void) setProperties: (NSDictionary *) properties
{
	[[self propertyWithCode:'pALL'] setTo:properties];
}


- (void) open
{
	[self sendEvent:'aevt' id:'odoc' parameters:0];
}

- (void) print
{
	[self sendEvent:'aevt' id:'pdoc' parameters:0];
}

- (void) closeSaving:(MailSavo)saving savingIn:(NSURL *)savingIn
{
	[self sendEvent:'core' id:'clos' parameters:'savo', [NSAppleEventDescriptor descriptorWithEnumCode:saving], 'kfil', savingIn, 0];
}

- (void) delete
{
	[self sendEvent:'core' id:'delo' parameters:0];
}

- (void) duplicateTo:(SBObject *)to
{
	[self sendEvent:'core' id:'clon' parameters:'insh', to, 0];
}

- (BOOL) exists
{
	id result__ = [self sendEvent:'core' id:'doex' parameters:0];
	return [result__ boolValue];
}

- (void) moveTo:(SBObject *)to
{
	[self sendEvent:'core' id:'move' parameters:'insh', to, 0];
}

- (void) saveIn:(NSURL *)in_ as:(NSString *)as
{
	[self sendEvent:'core' id:'save' parameters:'kfil', in_, 'fltp', as, 0];
}


@end


@implementation MailApplication

typedef struct { NSString *name; FourCharCode code; } classForCode_t;
static const classForCode_t classForCodeData__[] = {
	{ @"MailItem", 'cobj' },
	{ @"MailApplication", 'capp' },
	{ @"MailColor", 'colr' },
	{ @"MailDocument", 'docu' },
	{ @"MailWindow", 'cwin' },
	{ @"MailText", 'ctxt' },
	{ @"MailAttachment", 'atts' },
	{ @"MailParagraph", 'cpar' },
	{ @"MailWord", 'cwor' },
	{ @"MailCharacter", 'cha ' },
	{ @"MailAttributeRun", 'catr' },
	{ @"MailOutgoingMessage", 'bcke' },
	{ @"MailLdapServer", 'ldse' },
	{ @"MailMessageViewer", 'mvwr' },
	{ @"MailSignature", 'situ' },
	{ @"MailMessage", 'mssg' },
	{ @"MailAccount", 'mact' },
	{ @"MailImapAccount", 'iact' },
	{ @"MailMobileMeAccount", 'itac' },
	{ @"MailPopAccount", 'pact' },
	{ @"MailSmtpServer", 'dact' },
	{ @"MailMailbox", 'mbxp' },
	{ @"MailRule", 'rule' },
	{ @"MailRuleCondition", 'rucr' },
	{ @"MailRecipient", 'rcpt' },
	{ @"MailBccRecipient", 'brcp' },
	{ @"MailCcRecipient", 'crcp' },
	{ @"MailToRecipient", 'trcp' },
	{ @"MailContainer", 'mbxc' },
	{ @"MailHeader", 'mhdr' },
	{ @"MailMailAttachment", 'attc' },
	{ @"MailOLDMessageEditor", 'medt' },
	{ nil, 0 } 
};

- (NSDictionary *) classNamesForCodes
{
	static NSMutableDictionary *dict__;

	if (!dict__) @synchronized([self class]) {
	if (!dict__) {
		dict__ = [[NSMutableDictionary alloc] init];
		const classForCode_t *p;
		for (p = classForCodeData__; p->name != nil; ++p)
			[dict__ setObject:p->name forKey:[NSNumber numberWithInt:p->code]];
	} }
	return dict__;
}

typedef struct { FourCharCode code; NSString *name; } codeForPropertyName_t;
static const codeForPropertyName_t codeForPropertyNameData__[] = {
	{ 'pcls', @"objectClass" },
	{ 'pALL', @"properties" },
	{ 'pnam', @"name" },
	{ 'pisf', @"frontmost" },
	{ 'vers', @"version" },
	{ 'ppth', @"path" },
	{ 'imod', @"modified" },
	{ 'pnam', @"name" },
	{ 'pnam', @"name" },
	{ 'ID  ', @"id" },
	{ 'pbnd', @"bounds" },
	{ 'hclb', @"closeable" },
	{ 'ptit', @"titled" },
	{ 'pidx', @"index" },
	{ 'isfl', @"floating" },
	{ 'ismn', @"miniaturizable" },
	{ 'pmnd', @"miniaturized" },
	{ 'pmod', @"modal" },
	{ 'prsz', @"resizable" },
	{ 'pvis', @"visible" },
	{ 'iszm', @"zoomable" },
	{ 'pzum', @"zoomed" },
	{ 'colr', @"color" },
	{ 'font', @"font" },
	{ 'ptsz', @"size" },
	{ 'atfn', @"fileName" },
	{ 'sndr', @"sender" },
	{ 'subj', @"subject" },
	{ 'ctnt', @"content" },
	{ 'pvis', @"visible" },
	{ 'tnrg', @"messageSignature" },
	{ 'ID  ', @"id" },
	{ 'isac', @"enabled" },
	{ 'pnam', @"name" },
	{ 'port', @"port" },
	{ 'ldsc', @"scope" },
	{ 'ldsb', @"searchBase" },
	{ 'ldsa', @"hostName" },
	{ 'vers', @"version" },
	{ 'abcm', @"alwaysBccMyself" },
	{ 'accm', @"alwaysCcMyself" },
	{ 'slct', @"selection" },
	{ 'apve', @"applicationVersion" },
	{ 'affq', @"fetchInterval" },
	{ 'bthc', @"backgroundActivityCount" },
	{ 'cswc', @"chooseSignatureWhenComposing" },
	{ 'mcct', @"colorQuotedText" },
	{ 'demf', @"defaultMessageFormat" },
	{ 'dhta', @"downloadHtmlAttachments" },
	{ 'drmb', @"draftsMailbox" },
	{ 'exga', @"expandGroupAddresses" },
	{ 'mptf', @"fixedWidthFont" },
	{ 'ptfs', @"fixedWidthFontSize" },
	{ 'frve', @"frameworkVersion" },
	{ 'hedl', @"headerDetail" },
	{ 'inmb', @"inbox" },
	{ 'iaoo', @"includeAllOriginalMessageText" },
	{ 'inom', @"quoteOriginalMessage" },
	{ 'chsp', @"checkSpellingWhileTyping" },
	{ 'jkmb', @"junkMailbox" },
	{ 'loqc', @"levelOneQuotingColor" },
	{ 'lwqc', @"levelTwoQuotingColor" },
	{ 'lhqc', @"levelThreeQuotingColor" },
	{ 'mmfn', @"messageFont" },
	{ 'mmfs', @"messageFontSize" },
	{ 'mmlf', @"messageListFont" },
	{ 'mlfs', @"messageListFontSize" },
	{ 'mnms', @"newMailSound" },
	{ 'oumb', @"outbox" },
	{ 'poms', @"shouldPlayOtherMailSounds" },
	{ 'risf', @"sameReplyFormat" },
	{ 'sesi', @"selectedSignature" },
	{ 'stmb', @"sentMailbox" },
	{ 'saft', @"fetchesAutomatically" },
	{ 'shht', @"highlightSelectedThread" },
	{ 'shsp', @"showOnlineBuddyStatus" },
	{ 'trmb', @"trashMailbox" },
	{ 'usla', @"useAddressCompletion" },
	{ 'ufwf', @"useFixedWidthFont" },
	{ 'ueml', @"primaryEmail" },
	{ 'drmb', @"draftsMailbox" },
	{ 'inmb', @"inbox" },
	{ 'jkmb', @"junkMailbox" },
	{ 'oumb', @"outbox" },
	{ 'stmb', @"sentMailbox" },
	{ 'trmb', @"trashMailbox" },
	{ 'mvsc', @"sortColumn" },
	{ 'mvsr', @"sortedAscending" },
	{ 'mlsh', @"mailboxListVisible" },
	{ 'mvpv', @"previewPaneIsVisible" },
	{ 'mvvc', @"visibleColumns" },
	{ 'ID  ', @"id" },
	{ 'mvfm', @"visibleMessages" },
	{ 'smgs', @"selectedMessages" },
	{ 'msbx', @"selectedMailboxes" },
	{ 'cwin', @"window" },
	{ 'ctnt', @"content" },
	{ 'pnam', @"name" },
	{ 'ID  ', @"id" },
	{ 'alhe', @"allHeaders" },
	{ 'mcol', @"backgroundColor" },
	{ 'mbxp', @"mailbox" },
	{ 'ctnt', @"content" },
	{ 'rdrc', @"dateReceived" },
	{ 'drcv', @"dateSent" },
	{ 'isdl', @"deletedStatus" },
	{ 'isfl', @"flaggedStatus" },
	{ 'isjk', @"junkMailStatus" },
	{ 'isrd', @"readStatus" },
	{ 'meid', @"messageId" },
	{ 'raso', @"source" },
	{ 'rpto', @"replyTo" },
	{ 'msze', @"messageSize" },
	{ 'sndr', @"sender" },
	{ 'subj', @"subject" },
	{ 'isfw', @"wasForwarded" },
	{ 'isrc', @"wasRedirected" },
	{ 'isrp', @"wasRepliedTo" },
	{ 'dact', @"deliveryAccount" },
	{ 'pnam', @"name" },
	{ 'macp', @"password" },
	{ 'paus', @"authentication" },
	{ 'atyp', @"accountType" },
	{ 'emad', @"emailAddresses" },
	{ 'flln', @"fullName" },
	{ 'ejmf', @"emptyJunkMessagesFrequency" },
	{ 'esmf', @"emptySentMessagesFrequency" },
	{ 'etrf', @"emptyTrashFrequency" },
	{ 'ejmo', @"emptyJunkMessagesOnQuit" },
	{ 'esmo', @"emptySentMessagesOnQuit" },
	{ 'etoq', @"emptyTrashOnQuit" },
	{ 'isac', @"enabled" },
	{ 'unme', @"userName" },
	{ 'path', @"accountDirectory" },
	{ 'port', @"port" },
	{ 'host', @"serverName" },
	{ 'iwgm', @"includeWhenGettingNewMail" },
	{ 'smdm', @"moveDeletedMessagesToTrash" },
	{ 'usss', @"usesSsl" },
	{ 'cwcm', @"compactMailboxesWhenClosing" },
	{ 'msgc', @"messageCaching" },
	{ 'sdos', @"storeDraftsOnServer" },
	{ 'sjos', @"storeJunkMailOnServer" },
	{ 'ssos', @"storeSentMessagesOnServer" },
	{ 'stos', @"storeDeletedMessagesOnServer" },
	{ 'bmws', @"bigMessageWarningSize" },
	{ 'dmdi', @"delayedMessageDeletionInterval" },
	{ 'dmos', @"deleteMailOnServer" },
	{ 'dmwm', @"deleteMessagesWhenMovedFromInbox" },
	{ 'pnam', @"name" },
	{ 'macp', @"password" },
	{ 'atyp', @"accountType" },
	{ 'paus', @"authentication" },
	{ 'isac', @"enabled" },
	{ 'unme', @"userName" },
	{ 'port', @"port" },
	{ 'host', @"serverName" },
	{ 'usss', @"usesSsl" },
	{ 'pnam', @"name" },
	{ 'mbuc', @"unreadCount" },
	{ 'mact', @"account" },
	{ 'mbxc', @"container" },
	{ 'rcme', @"colorMessage" },
	{ 'rdme', @"deleteMessage" },
	{ 'rfte', @"forwardText" },
	{ 'rfad', @"forwardMessage" },
	{ 'rmfl', @"markFlagged" },
	{ 'rmre', @"markRead" },
	{ 'rpso', @"playSound" },
	{ 'rrad', @"redirectMessage" },
	{ 'rrte', @"replyText" },
	{ 'rras', @"runScript" },
	{ 'racm', @"allConditionsMustBeMet" },
	{ 'rcmb', @"copyMessage" },
	{ 'rtme', @"moveMessage" },
	{ 'htuc', @"highlightTextUsingColor" },
	{ 'isac', @"enabled" },
	{ 'pnam', @"name" },
	{ 'rscm', @"shouldCopyMessage" },
	{ 'rstm', @"shouldMoveMessage" },
	{ 'rser', @"stopEvaluatingRules" },
	{ 'rexp', @"expression" },
	{ 'rhed', @"header" },
	{ 'rqua', @"qualifier" },
	{ 'rtyp', @"ruleType" },
	{ 'radd', @"address" },
	{ 'pnam', @"name" },
	{ 'ctnt', @"content" },
	{ 'pnam', @"name" },
	{ 'pnam', @"name" },
	{ 'attp', @"MIMEType" },
	{ 'atsz', @"fileSize" },
	{ 'atdn', @"downloaded" },
	{ 'ID  ', @"id" },
	{ 'htda', @"htmlContent" },
	{ 'htvc', @"vcardPath" },
	{ 'laoh', @"hostsToLogActivityOn" },
	{ 'laop', @"portsToLogActivityOn" },
	{ 'laas', @"logAllSocketActivity" },
	{ 'mllg', @"logMessages" },
	{ 'mems', @"memoryStatistics" },
	{ 'uske', @"useKeychain" },
	{ 'bcke', @"OLDComposeMessage" },
	{ 'mvms', @"messages" },
	{ 0, nil } 
};

- (NSDictionary *) codesForPropertyNames
{
	static NSMutableDictionary *dict__;

	if (!dict__) @synchronized([self class]) {
	if (!dict__) {
		dict__ = [[NSMutableDictionary alloc] init];
		const codeForPropertyName_t *p;
		for (p = codeForPropertyNameData__; p->name != nil; ++p)
			[dict__ setObject:[NSNumber numberWithInt:p->code] forKey:p->name];
	} }
	return dict__;
}


- (SBElementArray *) documents
{
	return [self elementArrayWithCode:'docu'];
}


- (SBElementArray *) windows
{
	return [self elementArrayWithCode:'cwin'];
}



- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (BOOL) frontmost
{
	id v = [[self propertyWithCode:'pisf'] get];
	return [v boolValue];
}

- (NSString *) version
{
	return [[self propertyWithCode:'vers'] get];
}


- (void) quitSaving:(MailSavo)saving
{
	[self sendEvent:'aevt' id:'quit' parameters:'savo', [NSAppleEventDescriptor descriptorWithEnumCode:saving], 0];
}

- (void) checkForNewMailFor:(MailAccount *)for_
{
	[self sendEvent:'emal' id:'chma' parameters:'acna', for_, 0];
}

- (NSString *) extractNameFrom:(NSString *)x
{
	id result__ = [self sendEvent:'emal' id:'eafn' parameters:'----', x, 0];
	return result__;
}

- (NSString *) extractAddressFrom:(NSString *)x
{
	id result__ = [self sendEvent:'emal' id:'eaua' parameters:'----', x, 0];
	return result__;
}

- (void) GetURL:(NSString *)x
{
	[self sendEvent:'emal' id:'emtg' parameters:'----', x, 0];
}

- (void) importMailMailboxAt:(NSURL *)at
{
	[self sendEvent:'emal' id:'immx' parameters:'mbpt', at, 0];
}

- (void) mailto:(NSString *)x
{
	[self sendEvent:'emal' id:'emto' parameters:'----', x, 0];
}

- (void) performMailActionWithMessages:(NSArray *)x inMailboxes:(MailMailbox *)inMailboxes forRule:(MailRule *)forRule
{
	[self sendEvent:'emal' id:'cpma' parameters:'----', x, 'pmbx', inMailboxes, 'pmar', forRule, 0];
}

- (void) synchronizeWith:(MailAccount *)with
{
	[self sendEvent:'emal' id:'syac' parameters:'acna', with, 0];
}


@end


@implementation MailColor


- (void) open
{
	[self sendEvent:'aevt' id:'odoc' parameters:0];
}

- (void) print
{
	[self sendEvent:'aevt' id:'pdoc' parameters:0];
}

- (void) closeSaving:(MailSavo)saving savingIn:(NSURL *)savingIn
{
	[self sendEvent:'core' id:'clos' parameters:'savo', [NSAppleEventDescriptor descriptorWithEnumCode:saving], 'kfil', savingIn, 0];
}

- (void) delete
{
	[self sendEvent:'core' id:'delo' parameters:0];
}

- (void) duplicateTo:(SBObject *)to
{
	[self sendEvent:'core' id:'clon' parameters:'insh', to, 0];
}

- (BOOL) exists
{
	id result__ = [self sendEvent:'core' id:'doex' parameters:0];
	return [result__ boolValue];
}

- (void) moveTo:(SBObject *)to
{
	[self sendEvent:'core' id:'move' parameters:'insh', to, 0];
}

- (void) saveIn:(NSURL *)in_ as:(NSString *)as
{
	[self sendEvent:'core' id:'save' parameters:'kfil', in_, 'fltp', as, 0];
}


@end


@implementation MailDocument


- (NSString *) path
{
	return [[self propertyWithCode:'ppth'] get];
}

- (void) setPath: (NSString *) path
{
	[[self propertyWithCode:'ppth'] setTo:path];
}

- (BOOL) modified
{
	id v = [[self propertyWithCode:'imod'] get];
	return [v boolValue];
}

- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (void) setName: (NSString *) name
{
	[[self propertyWithCode:'pnam'] setTo:name];
}


- (void) open
{
	[self sendEvent:'aevt' id:'odoc' parameters:0];
}

- (void) print
{
	[self sendEvent:'aevt' id:'pdoc' parameters:0];
}

- (void) closeSaving:(MailSavo)saving savingIn:(NSURL *)savingIn
{
	[self sendEvent:'core' id:'clos' parameters:'savo', [NSAppleEventDescriptor descriptorWithEnumCode:saving], 'kfil', savingIn, 0];
}

- (void) delete
{
	[self sendEvent:'core' id:'delo' parameters:0];
}

- (void) duplicateTo:(SBObject *)to
{
	[self sendEvent:'core' id:'clon' parameters:'insh', to, 0];
}

- (BOOL) exists
{
	id result__ = [self sendEvent:'core' id:'doex' parameters:0];
	return [result__ boolValue];
}

- (void) moveTo:(SBObject *)to
{
	[self sendEvent:'core' id:'move' parameters:'insh', to, 0];
}

- (void) saveIn:(NSURL *)in_ as:(NSString *)as
{
	[self sendEvent:'core' id:'save' parameters:'kfil', in_, 'fltp', as, 0];
}


@end


@implementation MailWindow


- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (void) setName: (NSString *) name
{
	[[self propertyWithCode:'pnam'] setTo:name];
}

- (NSInteger) id
{
	id v = [[self propertyWithCode:'ID  '] get];
	return [v integerValue];
}

- (NSRect) bounds
{
	id v = [[self propertyWithCode:'pbnd'] get];
	return [v rectValue];
}

- (void) setBounds: (NSRect) bounds
{
	id v = [NSValue valueWithRect:bounds];
	[[self propertyWithCode:'pbnd'] setTo:v];
}

- (BOOL) closeable
{
	id v = [[self propertyWithCode:'hclb'] get];
	return [v boolValue];
}

- (BOOL) titled
{
	id v = [[self propertyWithCode:'ptit'] get];
	return [v boolValue];
}

- (NSInteger) index
{
	id v = [[self propertyWithCode:'pidx'] get];
	return [v integerValue];
}

- (void) setIndex: (NSInteger) index
{
	id v = [NSNumber numberWithInteger:index];
	[[self propertyWithCode:'pidx'] setTo:v];
}

- (BOOL) floating
{
	id v = [[self propertyWithCode:'isfl'] get];
	return [v boolValue];
}

- (BOOL) miniaturizable
{
	id v = [[self propertyWithCode:'ismn'] get];
	return [v boolValue];
}

- (BOOL) miniaturized
{
	id v = [[self propertyWithCode:'pmnd'] get];
	return [v boolValue];
}

- (void) setMiniaturized: (BOOL) miniaturized
{
	id v = [NSNumber numberWithBool:miniaturized];
	[[self propertyWithCode:'pmnd'] setTo:v];
}

- (BOOL) modal
{
	id v = [[self propertyWithCode:'pmod'] get];
	return [v boolValue];
}

- (BOOL) resizable
{
	id v = [[self propertyWithCode:'prsz'] get];
	return [v boolValue];
}

- (BOOL) visible
{
	id v = [[self propertyWithCode:'pvis'] get];
	return [v boolValue];
}

- (void) setVisible: (BOOL) visible
{
	id v = [NSNumber numberWithBool:visible];
	[[self propertyWithCode:'pvis'] setTo:v];
}

- (BOOL) zoomable
{
	id v = [[self propertyWithCode:'iszm'] get];
	return [v boolValue];
}

- (BOOL) zoomed
{
	id v = [[self propertyWithCode:'pzum'] get];
	return [v boolValue];
}

- (void) setZoomed: (BOOL) zoomed
{
	id v = [NSNumber numberWithBool:zoomed];
	[[self propertyWithCode:'pzum'] setTo:v];
}


- (void) open
{
	[self sendEvent:'aevt' id:'odoc' parameters:0];
}

- (void) print
{
	[self sendEvent:'aevt' id:'pdoc' parameters:0];
}

- (void) closeSaving:(MailSavo)saving savingIn:(NSURL *)savingIn
{
	[self sendEvent:'core' id:'clos' parameters:'savo', [NSAppleEventDescriptor descriptorWithEnumCode:saving], 'kfil', savingIn, 0];
}

- (void) delete
{
	[self sendEvent:'core' id:'delo' parameters:0];
}

- (void) duplicateTo:(SBObject *)to
{
	[self sendEvent:'core' id:'clon' parameters:'insh', to, 0];
}

- (BOOL) exists
{
	id result__ = [self sendEvent:'core' id:'doex' parameters:0];
	return [result__ boolValue];
}

- (void) moveTo:(SBObject *)to
{
	[self sendEvent:'core' id:'move' parameters:'insh', to, 0];
}

- (void) saveIn:(NSURL *)in_ as:(NSString *)as
{
	[self sendEvent:'core' id:'save' parameters:'kfil', in_, 'fltp', as, 0];
}


@end




/*
 * Text Suite
 */

@implementation MailText


- (SBElementArray *) paragraphs
{
	return [self elementArrayWithCode:'cpar'];
}


- (SBElementArray *) words
{
	return [self elementArrayWithCode:'cwor'];
}


- (SBElementArray *) characters
{
	return [self elementArrayWithCode:'cha '];
}


- (SBElementArray *) attributeRuns
{
	return [self elementArrayWithCode:'catr'];
}


- (SBElementArray *) attachments
{
	return [self elementArrayWithCode:'atts'];
}



- (NSColor *) color
{
	return [[self propertyWithCode:'colr'] get];
}

- (void) setColor: (NSColor *) color
{
	[[self propertyWithCode:'colr'] setTo:color];
}

- (NSString *) font
{
	return [[self propertyWithCode:'font'] get];
}

- (void) setFont: (NSString *) font
{
	[[self propertyWithCode:'font'] setTo:font];
}

- (NSNumber *) size
{
	return [[self propertyWithCode:'ptsz'] get];
}

- (void) setSize: (NSNumber *) size
{
	[[self propertyWithCode:'ptsz'] setTo:size];
}


- (void) open
{
	[self sendEvent:'aevt' id:'odoc' parameters:0];
}

- (void) print
{
	[self sendEvent:'aevt' id:'pdoc' parameters:0];
}

- (void) closeSaving:(MailSavo)saving savingIn:(NSURL *)savingIn
{
	[self sendEvent:'core' id:'clos' parameters:'savo', [NSAppleEventDescriptor descriptorWithEnumCode:saving], 'kfil', savingIn, 0];
}

- (void) delete
{
	[self sendEvent:'core' id:'delo' parameters:0];
}

- (void) duplicateTo:(SBObject *)to
{
	[self sendEvent:'core' id:'clon' parameters:'insh', to, 0];
}

- (BOOL) exists
{
	id result__ = [self sendEvent:'core' id:'doex' parameters:0];
	return [result__ boolValue];
}

- (void) moveTo:(SBObject *)to
{
	[self sendEvent:'core' id:'move' parameters:'insh', to, 0];
}

- (void) saveIn:(NSURL *)in_ as:(NSString *)as
{
	[self sendEvent:'core' id:'save' parameters:'kfil', in_, 'fltp', as, 0];
}

- (NSString *) extractNameFrom
{
	id result__ = [self sendEvent:'emal' id:'eafn' parameters:0];
	return result__;
}

- (NSString *) extractAddressFrom
{
	id result__ = [self sendEvent:'emal' id:'eaua' parameters:0];
	return result__;
}

- (void) GetURL
{
	[self sendEvent:'emal' id:'emtg' parameters:0];
}

- (void) mailto
{
	[self sendEvent:'emal' id:'emto' parameters:0];
}


@end


@implementation MailAttachment


- (NSString *) fileName
{
	return [[self propertyWithCode:'atfn'] get];
}

- (void) setFileName: (NSString *) fileName
{
	[[self propertyWithCode:'atfn'] setTo:fileName];
}



@end


@implementation MailParagraph



@end


@implementation MailWord



@end


@implementation MailCharacter



@end


@implementation MailAttributeRun



@end




/*
 * Mail
 */

@implementation MailOutgoingMessage


- (SBElementArray *) bccRecipients
{
	return [self elementArrayWithCode:'brcp'];
}


- (SBElementArray *) ccRecipients
{
	return [self elementArrayWithCode:'crcp'];
}


- (SBElementArray *) recipients
{
	return [self elementArrayWithCode:'rcpt'];
}


- (SBElementArray *) toRecipients
{
	return [self elementArrayWithCode:'trcp'];
}



- (NSString *) sender
{
	return [[self propertyWithCode:'sndr'] get];
}

- (void) setSender: (NSString *) sender
{
	[[self propertyWithCode:'sndr'] setTo:sender];
}

- (NSString *) subject
{
	return [[self propertyWithCode:'subj'] get];
}

- (void) setSubject: (NSString *) subject
{
	[[self propertyWithCode:'subj'] setTo:subject];
}

- (MailText *) content
{
	return (MailText *) [self propertyWithClass:[MailText class] code:'ctnt'];
}

- (void) setContent: (MailText *) content
{
	[[self propertyWithClass:[MailText class] code:'ctnt'] setTo:content];
}

- (BOOL) visible
{
	id v = [[self propertyWithCode:'pvis'] get];
	return [v boolValue];
}

- (void) setVisible: (BOOL) visible
{
	id v = [NSNumber numberWithBool:visible];
	[[self propertyWithCode:'pvis'] setTo:v];
}

- (MailSignature *) messageSignature
{
	return (MailSignature *) [self propertyWithClass:[MailSignature class] code:'tnrg'];
}

- (void) setMessageSignature: (MailSignature *) messageSignature
{
	[[self propertyWithClass:[MailSignature class] code:'tnrg'] setTo:messageSignature];
}

- (NSInteger) id
{
	id v = [[self propertyWithCode:'ID  '] get];
	return [v integerValue];
}


- (BOOL) send
{
	id result__ = [self sendEvent:'emsg' id:'send' parameters:0];
	return [result__ boolValue];
}


@end


@implementation MailLdapServer


- (BOOL) enabled
{
	id v = [[self propertyWithCode:'isac'] get];
	return [v boolValue];
}

- (void) setEnabled: (BOOL) enabled
{
	id v = [NSNumber numberWithBool:enabled];
	[[self propertyWithCode:'isac'] setTo:v];
}

- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (void) setName: (NSString *) name
{
	[[self propertyWithCode:'pnam'] setTo:name];
}

- (NSInteger) port
{
	id v = [[self propertyWithCode:'port'] get];
	return [v integerValue];
}

- (void) setPort: (NSInteger) port
{
	id v = [NSNumber numberWithInteger:port];
	[[self propertyWithCode:'port'] setTo:v];
}

- (MailLdas) scope
{
	id v = [[self propertyWithCode:'ldsc'] get];
	return [v enumCodeValue];
}

- (void) setScope: (MailLdas) scope
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:scope];
	[[self propertyWithCode:'ldsc'] setTo:v];
}

- (NSString *) searchBase
{
	return [[self propertyWithCode:'ldsb'] get];
}

- (void) setSearchBase: (NSString *) searchBase
{
	[[self propertyWithCode:'ldsb'] setTo:searchBase];
}

- (NSString *) hostName
{
	return [[self propertyWithCode:'ldsa'] get];
}

- (void) setHostName: (NSString *) hostName
{
	[[self propertyWithCode:'ldsa'] setTo:hostName];
}



@end


@implementation MailApplication(Mail)


- (SBElementArray *) accounts
{
	return [self elementArrayWithCode:'mact'];
}


- (SBElementArray *) popAccounts
{
	return [self elementArrayWithCode:'pact'];
}


- (SBElementArray *) imapAccounts
{
	return [self elementArrayWithCode:'iact'];
}


- (SBElementArray *) MobileMeAccounts
{
	return [self elementArrayWithCode:'itac'];
}


- (SBElementArray *) smtpServers
{
	return [self elementArrayWithCode:'dact'];
}


- (SBElementArray *) outgoingMessages
{
	return [self elementArrayWithCode:'bcke'];
}


- (SBElementArray *) ldapServers
{
	return [self elementArrayWithCode:'ldse'];
}


- (SBElementArray *) mailboxes
{
	return [self elementArrayWithCode:'mbxp'];
}


- (SBElementArray *) messageViewers
{
	return [self elementArrayWithCode:'mvwr'];
}


- (SBElementArray *) rules
{
	return [self elementArrayWithCode:'rule'];
}


- (SBElementArray *) signatures
{
	return [self elementArrayWithCode:'situ'];
}



- (NSString *) version
{
	return [[self propertyWithCode:'vers'] get];
}

- (BOOL) alwaysBccMyself
{
	id v = [[self propertyWithCode:'abcm'] get];
	return [v boolValue];
}

- (void) setAlwaysBccMyself: (BOOL) alwaysBccMyself
{
	id v = [NSNumber numberWithBool:alwaysBccMyself];
	[[self propertyWithCode:'abcm'] setTo:v];
}

- (BOOL) alwaysCcMyself
{
	id v = [[self propertyWithCode:'accm'] get];
	return [v boolValue];
}

- (void) setAlwaysCcMyself: (BOOL) alwaysCcMyself
{
	id v = [NSNumber numberWithBool:alwaysCcMyself];
	[[self propertyWithCode:'accm'] setTo:v];
}

- (NSArray *) selection
{
	return [[self propertyWithCode:'slct'] get];
}

- (NSString *) applicationVersion
{
	return [[self propertyWithCode:'apve'] get];
}

- (NSInteger) fetchInterval
{
	id v = [[self propertyWithCode:'affq'] get];
	return [v integerValue];
}

- (void) setFetchInterval: (NSInteger) fetchInterval
{
	id v = [NSNumber numberWithInteger:fetchInterval];
	[[self propertyWithCode:'affq'] setTo:v];
}

- (NSInteger) backgroundActivityCount
{
	id v = [[self propertyWithCode:'bthc'] get];
	return [v integerValue];
}

- (BOOL) chooseSignatureWhenComposing
{
	id v = [[self propertyWithCode:'cswc'] get];
	return [v boolValue];
}

- (void) setChooseSignatureWhenComposing: (BOOL) chooseSignatureWhenComposing
{
	id v = [NSNumber numberWithBool:chooseSignatureWhenComposing];
	[[self propertyWithCode:'cswc'] setTo:v];
}

- (BOOL) colorQuotedText
{
	id v = [[self propertyWithCode:'mcct'] get];
	return [v boolValue];
}

- (void) setColorQuotedText: (BOOL) colorQuotedText
{
	id v = [NSNumber numberWithBool:colorQuotedText];
	[[self propertyWithCode:'mcct'] setTo:v];
}

- (MailEdmf) defaultMessageFormat
{
	id v = [[self propertyWithCode:'demf'] get];
	return [v enumCodeValue];
}

- (void) setDefaultMessageFormat: (MailEdmf) defaultMessageFormat
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:defaultMessageFormat];
	[[self propertyWithCode:'demf'] setTo:v];
}

- (BOOL) downloadHtmlAttachments
{
	id v = [[self propertyWithCode:'dhta'] get];
	return [v boolValue];
}

- (void) setDownloadHtmlAttachments: (BOOL) downloadHtmlAttachments
{
	id v = [NSNumber numberWithBool:downloadHtmlAttachments];
	[[self propertyWithCode:'dhta'] setTo:v];
}

- (MailMailbox *) draftsMailbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'drmb'];
}

- (BOOL) expandGroupAddresses
{
	id v = [[self propertyWithCode:'exga'] get];
	return [v boolValue];
}

- (void) setExpandGroupAddresses: (BOOL) expandGroupAddresses
{
	id v = [NSNumber numberWithBool:expandGroupAddresses];
	[[self propertyWithCode:'exga'] setTo:v];
}

- (NSString *) fixedWidthFont
{
	return [[self propertyWithCode:'mptf'] get];
}

- (void) setFixedWidthFont: (NSString *) fixedWidthFont
{
	[[self propertyWithCode:'mptf'] setTo:fixedWidthFont];
}

- (double) fixedWidthFontSize
{
	id v = [[self propertyWithCode:'ptfs'] get];
	return [v doubleValue];
}

- (void) setFixedWidthFontSize: (double) fixedWidthFontSize
{
	id v = [NSNumber numberWithDouble:fixedWidthFontSize];
	[[self propertyWithCode:'ptfs'] setTo:v];
}

- (NSString *) frameworkVersion
{
	return [[self propertyWithCode:'frve'] get];
}

- (MailHede) headerDetail
{
	id v = [[self propertyWithCode:'hedl'] get];
	return [v enumCodeValue];
}

- (void) setHeaderDetail: (MailHede) headerDetail
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:headerDetail];
	[[self propertyWithCode:'hedl'] setTo:v];
}

- (MailMailbox *) inbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'inmb'];
}

- (BOOL) includeAllOriginalMessageText
{
	id v = [[self propertyWithCode:'iaoo'] get];
	return [v boolValue];
}

- (void) setIncludeAllOriginalMessageText: (BOOL) includeAllOriginalMessageText
{
	id v = [NSNumber numberWithBool:includeAllOriginalMessageText];
	[[self propertyWithCode:'iaoo'] setTo:v];
}

- (BOOL) quoteOriginalMessage
{
	id v = [[self propertyWithCode:'inom'] get];
	return [v boolValue];
}

- (void) setQuoteOriginalMessage: (BOOL) quoteOriginalMessage
{
	id v = [NSNumber numberWithBool:quoteOriginalMessage];
	[[self propertyWithCode:'inom'] setTo:v];
}

- (BOOL) checkSpellingWhileTyping
{
	id v = [[self propertyWithCode:'chsp'] get];
	return [v boolValue];
}

- (void) setCheckSpellingWhileTyping: (BOOL) checkSpellingWhileTyping
{
	id v = [NSNumber numberWithBool:checkSpellingWhileTyping];
	[[self propertyWithCode:'chsp'] setTo:v];
}

- (MailMailbox *) junkMailbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'jkmb'];
}

- (MailQqcl) levelOneQuotingColor
{
	id v = [[self propertyWithCode:'loqc'] get];
	return [v enumCodeValue];
}

- (void) setLevelOneQuotingColor: (MailQqcl) levelOneQuotingColor
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:levelOneQuotingColor];
	[[self propertyWithCode:'loqc'] setTo:v];
}

- (MailQqcl) levelTwoQuotingColor
{
	id v = [[self propertyWithCode:'lwqc'] get];
	return [v enumCodeValue];
}

- (void) setLevelTwoQuotingColor: (MailQqcl) levelTwoQuotingColor
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:levelTwoQuotingColor];
	[[self propertyWithCode:'lwqc'] setTo:v];
}

- (MailQqcl) levelThreeQuotingColor
{
	id v = [[self propertyWithCode:'lhqc'] get];
	return [v enumCodeValue];
}

- (void) setLevelThreeQuotingColor: (MailQqcl) levelThreeQuotingColor
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:levelThreeQuotingColor];
	[[self propertyWithCode:'lhqc'] setTo:v];
}

- (NSString *) messageFont
{
	return [[self propertyWithCode:'mmfn'] get];
}

- (void) setMessageFont: (NSString *) messageFont
{
	[[self propertyWithCode:'mmfn'] setTo:messageFont];
}

- (double) messageFontSize
{
	id v = [[self propertyWithCode:'mmfs'] get];
	return [v doubleValue];
}

- (void) setMessageFontSize: (double) messageFontSize
{
	id v = [NSNumber numberWithDouble:messageFontSize];
	[[self propertyWithCode:'mmfs'] setTo:v];
}

- (NSString *) messageListFont
{
	return [[self propertyWithCode:'mmlf'] get];
}

- (void) setMessageListFont: (NSString *) messageListFont
{
	[[self propertyWithCode:'mmlf'] setTo:messageListFont];
}

- (double) messageListFontSize
{
	id v = [[self propertyWithCode:'mlfs'] get];
	return [v doubleValue];
}

- (void) setMessageListFontSize: (double) messageListFontSize
{
	id v = [NSNumber numberWithDouble:messageListFontSize];
	[[self propertyWithCode:'mlfs'] setTo:v];
}

- (NSString *) newMailSound
{
	return [[self propertyWithCode:'mnms'] get];
}

- (void) setNewMailSound: (NSString *) newMailSound
{
	[[self propertyWithCode:'mnms'] setTo:newMailSound];
}

- (MailMailbox *) outbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'oumb'];
}

- (BOOL) shouldPlayOtherMailSounds
{
	id v = [[self propertyWithCode:'poms'] get];
	return [v boolValue];
}

- (void) setShouldPlayOtherMailSounds: (BOOL) shouldPlayOtherMailSounds
{
	id v = [NSNumber numberWithBool:shouldPlayOtherMailSounds];
	[[self propertyWithCode:'poms'] setTo:v];
}

- (BOOL) sameReplyFormat
{
	id v = [[self propertyWithCode:'risf'] get];
	return [v boolValue];
}

- (void) setSameReplyFormat: (BOOL) sameReplyFormat
{
	id v = [NSNumber numberWithBool:sameReplyFormat];
	[[self propertyWithCode:'risf'] setTo:v];
}

- (NSString *) selectedSignature
{
	return [[self propertyWithCode:'sesi'] get];
}

- (void) setSelectedSignature: (NSString *) selectedSignature
{
	[[self propertyWithCode:'sesi'] setTo:selectedSignature];
}

- (MailMailbox *) sentMailbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'stmb'];
}

- (BOOL) fetchesAutomatically
{
	id v = [[self propertyWithCode:'saft'] get];
	return [v boolValue];
}

- (void) setFetchesAutomatically: (BOOL) fetchesAutomatically
{
	id v = [NSNumber numberWithBool:fetchesAutomatically];
	[[self propertyWithCode:'saft'] setTo:v];
}

- (BOOL) highlightSelectedThread
{
	id v = [[self propertyWithCode:'shht'] get];
	return [v boolValue];
}

- (void) setHighlightSelectedThread: (BOOL) highlightSelectedThread
{
	id v = [NSNumber numberWithBool:highlightSelectedThread];
	[[self propertyWithCode:'shht'] setTo:v];
}

- (BOOL) showOnlineBuddyStatus
{
	id v = [[self propertyWithCode:'shsp'] get];
	return [v boolValue];
}

- (void) setShowOnlineBuddyStatus: (BOOL) showOnlineBuddyStatus
{
	id v = [NSNumber numberWithBool:showOnlineBuddyStatus];
	[[self propertyWithCode:'shsp'] setTo:v];
}

- (MailMailbox *) trashMailbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'trmb'];
}

- (BOOL) useAddressCompletion
{
	id v = [[self propertyWithCode:'usla'] get];
	return [v boolValue];
}

- (void) setUseAddressCompletion: (BOOL) useAddressCompletion
{
	id v = [NSNumber numberWithBool:useAddressCompletion];
	[[self propertyWithCode:'usla'] setTo:v];
}

- (BOOL) useFixedWidthFont
{
	id v = [[self propertyWithCode:'ufwf'] get];
	return [v boolValue];
}

- (void) setUseFixedWidthFont: (BOOL) useFixedWidthFont
{
	id v = [NSNumber numberWithBool:useFixedWidthFont];
	[[self propertyWithCode:'ufwf'] setTo:v];
}

- (NSString *) primaryEmail
{
	return [[self propertyWithCode:'ueml'] get];
}


@end


@implementation MailMessageViewer


- (SBElementArray *) messages
{
	return [self elementArrayWithCode:'mssg'];
}



- (MailMailbox *) draftsMailbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'drmb'];
}

- (MailMailbox *) inbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'inmb'];
}

- (MailMailbox *) junkMailbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'jkmb'];
}

- (MailMailbox *) outbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'oumb'];
}

- (MailMailbox *) sentMailbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'stmb'];
}

- (MailMailbox *) trashMailbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'trmb'];
}

- (MailMvcl) sortColumn
{
	id v = [[self propertyWithCode:'mvsc'] get];
	return [v enumCodeValue];
}

- (void) setSortColumn: (MailMvcl) sortColumn
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:sortColumn];
	[[self propertyWithCode:'mvsc'] setTo:v];
}

- (BOOL) sortedAscending
{
	id v = [[self propertyWithCode:'mvsr'] get];
	return [v boolValue];
}

- (void) setSortedAscending: (BOOL) sortedAscending
{
	id v = [NSNumber numberWithBool:sortedAscending];
	[[self propertyWithCode:'mvsr'] setTo:v];
}

- (BOOL) mailboxListVisible
{
	id v = [[self propertyWithCode:'mlsh'] get];
	return [v boolValue];
}

- (void) setMailboxListVisible: (BOOL) mailboxListVisible
{
	id v = [NSNumber numberWithBool:mailboxListVisible];
	[[self propertyWithCode:'mlsh'] setTo:v];
}

- (BOOL) previewPaneIsVisible
{
	id v = [[self propertyWithCode:'mvpv'] get];
	return [v boolValue];
}

- (void) setPreviewPaneIsVisible: (BOOL) previewPaneIsVisible
{
	id v = [NSNumber numberWithBool:previewPaneIsVisible];
	[[self propertyWithCode:'mvpv'] setTo:v];
}

- (MailMvcl) visibleColumns
{
	id v = [[self propertyWithCode:'mvvc'] get];
	return [v enumCodeValue];
}

- (void) setVisibleColumns: (MailMvcl) visibleColumns
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:visibleColumns];
	[[self propertyWithCode:'mvvc'] setTo:v];
}

- (NSInteger) id
{
	id v = [[self propertyWithCode:'ID  '] get];
	return [v integerValue];
}

- (NSArray *) visibleMessages
{
	return [[self propertyWithCode:'mvfm'] get];
}

- (void) setVisibleMessages: (NSArray *) visibleMessages
{
	[[self propertyWithCode:'mvfm'] setTo:visibleMessages];
}

- (NSArray *) selectedMessages
{
	return [[self propertyWithCode:'smgs'] get];
}

- (void) setSelectedMessages: (NSArray *) selectedMessages
{
	[[self propertyWithCode:'smgs'] setTo:selectedMessages];
}

- (NSArray *) selectedMailboxes
{
	return [[self propertyWithCode:'msbx'] get];
}

- (void) setSelectedMailboxes: (NSArray *) selectedMailboxes
{
	[[self propertyWithCode:'msbx'] setTo:selectedMailboxes];
}

- (MailWindow *) window
{
	return (MailWindow *) [self propertyWithClass:[MailWindow class] code:'cwin'];
}

- (void) setWindow: (MailWindow *) window
{
	[[self propertyWithClass:[MailWindow class] code:'cwin'] setTo:window];
}



@end


@implementation MailSignature


- (NSString *) content
{
	return [[self propertyWithCode:'ctnt'] get];
}

- (void) setContent: (NSString *) content
{
	[[self propertyWithCode:'ctnt'] setTo:content];
}

- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (void) setName: (NSString *) name
{
	[[self propertyWithCode:'pnam'] setTo:name];
}



@end




/*
 * Message
 */

@implementation MailMessage


- (SBElementArray *) bccRecipients
{
	return [self elementArrayWithCode:'brcp'];
}


- (SBElementArray *) ccRecipients
{
	return [self elementArrayWithCode:'crcp'];
}


- (SBElementArray *) recipients
{
	return [self elementArrayWithCode:'rcpt'];
}


- (SBElementArray *) toRecipients
{
	return [self elementArrayWithCode:'trcp'];
}


- (SBElementArray *) headers
{
	return [self elementArrayWithCode:'mhdr'];
}


- (SBElementArray *) mailAttachments
{
	return [self elementArrayWithCode:'attc'];
}



- (NSInteger) id
{
	id v = [[self propertyWithCode:'ID  '] get];
	return [v integerValue];
}

- (NSString *) allHeaders
{
	return [[self propertyWithCode:'alhe'] get];
}

- (MailCclr) backgroundColor
{
	id v = [[self propertyWithCode:'mcol'] get];
	return [v enumCodeValue];
}

- (void) setBackgroundColor: (MailCclr) backgroundColor
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:backgroundColor];
	[[self propertyWithCode:'mcol'] setTo:v];
}

- (MailMailbox *) mailbox
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'mbxp'];
}

- (void) setMailbox: (MailMailbox *) mailbox
{
	[[self propertyWithClass:[MailMailbox class] code:'mbxp'] setTo:mailbox];
}

- (MailText *) content
{
	return (MailText *) [self propertyWithClass:[MailText class] code:'ctnt'];
}

- (NSDate *) dateReceived
{
	return [[self propertyWithCode:'rdrc'] get];
}

- (NSDate *) dateSent
{
	return [[self propertyWithCode:'drcv'] get];
}

- (BOOL) deletedStatus
{
	id v = [[self propertyWithCode:'isdl'] get];
	return [v boolValue];
}

- (void) setDeletedStatus: (BOOL) deletedStatus
{
	id v = [NSNumber numberWithBool:deletedStatus];
	[[self propertyWithCode:'isdl'] setTo:v];
}

- (BOOL) flaggedStatus
{
	id v = [[self propertyWithCode:'isfl'] get];
	return [v boolValue];
}

- (void) setFlaggedStatus: (BOOL) flaggedStatus
{
	id v = [NSNumber numberWithBool:flaggedStatus];
	[[self propertyWithCode:'isfl'] setTo:v];
}

- (BOOL) junkMailStatus
{
	id v = [[self propertyWithCode:'isjk'] get];
	return [v boolValue];
}

- (void) setJunkMailStatus: (BOOL) junkMailStatus
{
	id v = [NSNumber numberWithBool:junkMailStatus];
	[[self propertyWithCode:'isjk'] setTo:v];
}

- (BOOL) readStatus
{
	id v = [[self propertyWithCode:'isrd'] get];
	return [v boolValue];
}

- (void) setReadStatus: (BOOL) readStatus
{
	id v = [NSNumber numberWithBool:readStatus];
	[[self propertyWithCode:'isrd'] setTo:v];
}

- (NSString *) messageId
{
	return [[self propertyWithCode:'meid'] get];
}

- (NSString *) source
{
	return [[self propertyWithCode:'raso'] get];
}

- (NSString *) replyTo
{
	return [[self propertyWithCode:'rpto'] get];
}

- (NSInteger) messageSize
{
	id v = [[self propertyWithCode:'msze'] get];
	return [v integerValue];
}

- (NSString *) sender
{
	return [[self propertyWithCode:'sndr'] get];
}

- (NSString *) subject
{
	return [[self propertyWithCode:'subj'] get];
}

- (BOOL) wasForwarded
{
	id v = [[self propertyWithCode:'isfw'] get];
	return [v boolValue];
}

- (BOOL) wasRedirected
{
	id v = [[self propertyWithCode:'isrc'] get];
	return [v boolValue];
}

- (BOOL) wasRepliedTo
{
	id v = [[self propertyWithCode:'isrp'] get];
	return [v boolValue];
}


- (void) bounce
{
	[self sendEvent:'emal' id:'bcms' parameters:0];
}

- (void) delete
{
	[self sendEvent:'core' id:'delo' parameters:0];
}

- (void) duplicateTo:(MailMailbox *)to
{
	[self sendEvent:'core' id:'clon' parameters:'insh', to, 0];
}

- (MailOutgoingMessage *) forwardOpeningWindow:(BOOL)openingWindow
{
	id result__ = [self sendEvent:'emal' id:'fwms' parameters:'ropw', [NSNumber numberWithBool:openingWindow], 0];
	return result__;
}

- (void) moveTo:(MailMailbox *)to
{
	[self sendEvent:'core' id:'move' parameters:'insh', to, 0];
}

- (MailOutgoingMessage *) redirectOpeningWindow:(BOOL)openingWindow
{
	id result__ = [self sendEvent:'emal' id:'rdms' parameters:'ropw', [NSNumber numberWithBool:openingWindow], 0];
	return result__;
}

- (MailOutgoingMessage *) replyOpeningWindow:(BOOL)openingWindow replyToAll:(BOOL)replyToAll
{
	id result__ = [self sendEvent:'emal' id:'rpms' parameters:'ropw', [NSNumber numberWithBool:openingWindow], 'rpal', [NSNumber numberWithBool:replyToAll], 0];
	return result__;
}


@end


@implementation MailAccount


- (SBElementArray *) mailboxes
{
	return [self elementArrayWithCode:'mbxp'];
}



- (MailSmtpServer *) deliveryAccount
{
	return (MailSmtpServer *) [self propertyWithClass:[MailSmtpServer class] code:'dact'];
}

- (void) setDeliveryAccount: (MailSmtpServer *) deliveryAccount
{
	[[self propertyWithClass:[MailSmtpServer class] code:'dact'] setTo:deliveryAccount];
}

- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (void) setName: (NSString *) name
{
	[[self propertyWithCode:'pnam'] setTo:name];
}

- (NSString *) password
{
	return [[self propertyWithCode:'macp'] get];
}

- (void) setPassword: (NSString *) password
{
	[[self propertyWithCode:'macp'] setTo:password];
}

- (MailExut) authentication
{
	id v = [[self propertyWithCode:'paus'] get];
	return [v enumCodeValue];
}

- (void) setAuthentication: (MailExut) authentication
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:authentication];
	[[self propertyWithCode:'paus'] setTo:v];
}

- (MailEtoc) accountType
{
	id v = [[self propertyWithCode:'atyp'] get];
	return [v enumCodeValue];
}

- (NSArray *) emailAddresses
{
	return [[self propertyWithCode:'emad'] get];
}

- (void) setEmailAddresses: (NSArray *) emailAddresses
{
	[[self propertyWithCode:'emad'] setTo:emailAddresses];
}

- (NSString *) fullName
{
	return [[self propertyWithCode:'flln'] get];
}

- (void) setFullName: (NSString *) fullName
{
	[[self propertyWithCode:'flln'] setTo:fullName];
}

- (NSInteger) emptyJunkMessagesFrequency
{
	id v = [[self propertyWithCode:'ejmf'] get];
	return [v integerValue];
}

- (void) setEmptyJunkMessagesFrequency: (NSInteger) emptyJunkMessagesFrequency
{
	id v = [NSNumber numberWithInteger:emptyJunkMessagesFrequency];
	[[self propertyWithCode:'ejmf'] setTo:v];
}

- (NSInteger) emptySentMessagesFrequency
{
	id v = [[self propertyWithCode:'esmf'] get];
	return [v integerValue];
}

- (void) setEmptySentMessagesFrequency: (NSInteger) emptySentMessagesFrequency
{
	id v = [NSNumber numberWithInteger:emptySentMessagesFrequency];
	[[self propertyWithCode:'esmf'] setTo:v];
}

- (NSInteger) emptyTrashFrequency
{
	id v = [[self propertyWithCode:'etrf'] get];
	return [v integerValue];
}

- (void) setEmptyTrashFrequency: (NSInteger) emptyTrashFrequency
{
	id v = [NSNumber numberWithInteger:emptyTrashFrequency];
	[[self propertyWithCode:'etrf'] setTo:v];
}

- (BOOL) emptyJunkMessagesOnQuit
{
	id v = [[self propertyWithCode:'ejmo'] get];
	return [v boolValue];
}

- (void) setEmptyJunkMessagesOnQuit: (BOOL) emptyJunkMessagesOnQuit
{
	id v = [NSNumber numberWithBool:emptyJunkMessagesOnQuit];
	[[self propertyWithCode:'ejmo'] setTo:v];
}

- (BOOL) emptySentMessagesOnQuit
{
	id v = [[self propertyWithCode:'esmo'] get];
	return [v boolValue];
}

- (void) setEmptySentMessagesOnQuit: (BOOL) emptySentMessagesOnQuit
{
	id v = [NSNumber numberWithBool:emptySentMessagesOnQuit];
	[[self propertyWithCode:'esmo'] setTo:v];
}

- (BOOL) emptyTrashOnQuit
{
	id v = [[self propertyWithCode:'etoq'] get];
	return [v boolValue];
}

- (void) setEmptyTrashOnQuit: (BOOL) emptyTrashOnQuit
{
	id v = [NSNumber numberWithBool:emptyTrashOnQuit];
	[[self propertyWithCode:'etoq'] setTo:v];
}

- (BOOL) enabled
{
	id v = [[self propertyWithCode:'isac'] get];
	return [v boolValue];
}

- (void) setEnabled: (BOOL) enabled
{
	id v = [NSNumber numberWithBool:enabled];
	[[self propertyWithCode:'isac'] setTo:v];
}

- (NSString *) userName
{
	return [[self propertyWithCode:'unme'] get];
}

- (void) setUserName: (NSString *) userName
{
	[[self propertyWithCode:'unme'] setTo:userName];
}

- (NSURL *) accountDirectory
{
	return [[self propertyWithCode:'path'] get];
}

- (NSInteger) port
{
	id v = [[self propertyWithCode:'port'] get];
	return [v integerValue];
}

- (void) setPort: (NSInteger) port
{
	id v = [NSNumber numberWithInteger:port];
	[[self propertyWithCode:'port'] setTo:v];
}

- (NSString *) serverName
{
	return [[self propertyWithCode:'host'] get];
}

- (void) setServerName: (NSString *) serverName
{
	[[self propertyWithCode:'host'] setTo:serverName];
}

- (BOOL) includeWhenGettingNewMail
{
	id v = [[self propertyWithCode:'iwgm'] get];
	return [v boolValue];
}

- (void) setIncludeWhenGettingNewMail: (BOOL) includeWhenGettingNewMail
{
	id v = [NSNumber numberWithBool:includeWhenGettingNewMail];
	[[self propertyWithCode:'iwgm'] setTo:v];
}

- (BOOL) moveDeletedMessagesToTrash
{
	id v = [[self propertyWithCode:'smdm'] get];
	return [v boolValue];
}

- (void) setMoveDeletedMessagesToTrash: (BOOL) moveDeletedMessagesToTrash
{
	id v = [NSNumber numberWithBool:moveDeletedMessagesToTrash];
	[[self propertyWithCode:'smdm'] setTo:v];
}

- (BOOL) usesSsl
{
	id v = [[self propertyWithCode:'usss'] get];
	return [v boolValue];
}

- (void) setUsesSsl: (BOOL) usesSsl
{
	id v = [NSNumber numberWithBool:usesSsl];
	[[self propertyWithCode:'usss'] setTo:v];
}



@end


@implementation MailImapAccount


- (BOOL) compactMailboxesWhenClosing
{
	id v = [[self propertyWithCode:'cwcm'] get];
	return [v boolValue];
}

- (void) setCompactMailboxesWhenClosing: (BOOL) compactMailboxesWhenClosing
{
	id v = [NSNumber numberWithBool:compactMailboxesWhenClosing];
	[[self propertyWithCode:'cwcm'] setTo:v];
}

- (MailE9xp) messageCaching
{
	id v = [[self propertyWithCode:'msgc'] get];
	return [v enumCodeValue];
}

- (void) setMessageCaching: (MailE9xp) messageCaching
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:messageCaching];
	[[self propertyWithCode:'msgc'] setTo:v];
}

- (BOOL) storeDraftsOnServer
{
	id v = [[self propertyWithCode:'sdos'] get];
	return [v boolValue];
}

- (void) setStoreDraftsOnServer: (BOOL) storeDraftsOnServer
{
	id v = [NSNumber numberWithBool:storeDraftsOnServer];
	[[self propertyWithCode:'sdos'] setTo:v];
}

- (BOOL) storeJunkMailOnServer
{
	id v = [[self propertyWithCode:'sjos'] get];
	return [v boolValue];
}

- (void) setStoreJunkMailOnServer: (BOOL) storeJunkMailOnServer
{
	id v = [NSNumber numberWithBool:storeJunkMailOnServer];
	[[self propertyWithCode:'sjos'] setTo:v];
}

- (BOOL) storeSentMessagesOnServer
{
	id v = [[self propertyWithCode:'ssos'] get];
	return [v boolValue];
}

- (void) setStoreSentMessagesOnServer: (BOOL) storeSentMessagesOnServer
{
	id v = [NSNumber numberWithBool:storeSentMessagesOnServer];
	[[self propertyWithCode:'ssos'] setTo:v];
}

- (BOOL) storeDeletedMessagesOnServer
{
	id v = [[self propertyWithCode:'stos'] get];
	return [v boolValue];
}

- (void) setStoreDeletedMessagesOnServer: (BOOL) storeDeletedMessagesOnServer
{
	id v = [NSNumber numberWithBool:storeDeletedMessagesOnServer];
	[[self propertyWithCode:'stos'] setTo:v];
}



@end


@implementation MailMobileMeAccount



@end


@implementation MailPopAccount


- (NSInteger) bigMessageWarningSize
{
	id v = [[self propertyWithCode:'bmws'] get];
	return [v integerValue];
}

- (void) setBigMessageWarningSize: (NSInteger) bigMessageWarningSize
{
	id v = [NSNumber numberWithInteger:bigMessageWarningSize];
	[[self propertyWithCode:'bmws'] setTo:v];
}

- (NSInteger) delayedMessageDeletionInterval
{
	id v = [[self propertyWithCode:'dmdi'] get];
	return [v integerValue];
}

- (void) setDelayedMessageDeletionInterval: (NSInteger) delayedMessageDeletionInterval
{
	id v = [NSNumber numberWithInteger:delayedMessageDeletionInterval];
	[[self propertyWithCode:'dmdi'] setTo:v];
}

- (BOOL) deleteMailOnServer
{
	id v = [[self propertyWithCode:'dmos'] get];
	return [v boolValue];
}

- (void) setDeleteMailOnServer: (BOOL) deleteMailOnServer
{
	id v = [NSNumber numberWithBool:deleteMailOnServer];
	[[self propertyWithCode:'dmos'] setTo:v];
}

- (BOOL) deleteMessagesWhenMovedFromInbox
{
	id v = [[self propertyWithCode:'dmwm'] get];
	return [v boolValue];
}

- (void) setDeleteMessagesWhenMovedFromInbox: (BOOL) deleteMessagesWhenMovedFromInbox
{
	id v = [NSNumber numberWithBool:deleteMessagesWhenMovedFromInbox];
	[[self propertyWithCode:'dmwm'] setTo:v];
}



@end


@implementation MailSmtpServer


- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (NSString *) password
{
	return [[self propertyWithCode:'macp'] get];
}

- (void) setPassword: (NSString *) password
{
	[[self propertyWithCode:'macp'] setTo:password];
}

- (MailEtoc) accountType
{
	id v = [[self propertyWithCode:'atyp'] get];
	return [v enumCodeValue];
}

- (MailExut) authentication
{
	id v = [[self propertyWithCode:'paus'] get];
	return [v enumCodeValue];
}

- (void) setAuthentication: (MailExut) authentication
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:authentication];
	[[self propertyWithCode:'paus'] setTo:v];
}

- (BOOL) enabled
{
	id v = [[self propertyWithCode:'isac'] get];
	return [v boolValue];
}

- (void) setEnabled: (BOOL) enabled
{
	id v = [NSNumber numberWithBool:enabled];
	[[self propertyWithCode:'isac'] setTo:v];
}

- (NSString *) userName
{
	return [[self propertyWithCode:'unme'] get];
}

- (void) setUserName: (NSString *) userName
{
	[[self propertyWithCode:'unme'] setTo:userName];
}

- (NSInteger) port
{
	id v = [[self propertyWithCode:'port'] get];
	return [v integerValue];
}

- (void) setPort: (NSInteger) port
{
	id v = [NSNumber numberWithInteger:port];
	[[self propertyWithCode:'port'] setTo:v];
}

- (NSString *) serverName
{
	return [[self propertyWithCode:'host'] get];
}

- (void) setServerName: (NSString *) serverName
{
	[[self propertyWithCode:'host'] setTo:serverName];
}

- (BOOL) usesSsl
{
	id v = [[self propertyWithCode:'usss'] get];
	return [v boolValue];
}

- (void) setUsesSsl: (BOOL) usesSsl
{
	id v = [NSNumber numberWithBool:usesSsl];
	[[self propertyWithCode:'usss'] setTo:v];
}



@end


@implementation MailMailbox


- (SBElementArray *) mailboxes
{
	return [self elementArrayWithCode:'mbxp'];
}


- (SBElementArray *) messages
{
	return [self elementArrayWithCode:'mssg'];
}



- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (void) setName: (NSString *) name
{
	[[self propertyWithCode:'pnam'] setTo:name];
}

- (NSInteger) unreadCount
{
	id v = [[self propertyWithCode:'mbuc'] get];
	return [v integerValue];
}

- (MailAccount *) account
{
	return (MailAccount *) [self propertyWithClass:[MailAccount class] code:'mact'];
}

- (MailMailbox *) container
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'mbxc'];
}



@end


@implementation MailRule


- (SBElementArray *) ruleConditions
{
	return [self elementArrayWithCode:'rucr'];
}



- (MailCclr) colorMessage
{
	id v = [[self propertyWithCode:'rcme'] get];
	return [v enumCodeValue];
}

- (void) setColorMessage: (MailCclr) colorMessage
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:colorMessage];
	[[self propertyWithCode:'rcme'] setTo:v];
}

- (BOOL) deleteMessage
{
	id v = [[self propertyWithCode:'rdme'] get];
	return [v boolValue];
}

- (void) setDeleteMessage: (BOOL) deleteMessage
{
	id v = [NSNumber numberWithBool:deleteMessage];
	[[self propertyWithCode:'rdme'] setTo:v];
}

- (NSString *) forwardText
{
	return [[self propertyWithCode:'rfte'] get];
}

- (void) setForwardText: (NSString *) forwardText
{
	[[self propertyWithCode:'rfte'] setTo:forwardText];
}

- (NSString *) forwardMessage
{
	return [[self propertyWithCode:'rfad'] get];
}

- (void) setForwardMessage: (NSString *) forwardMessage
{
	[[self propertyWithCode:'rfad'] setTo:forwardMessage];
}

- (BOOL) markFlagged
{
	id v = [[self propertyWithCode:'rmfl'] get];
	return [v boolValue];
}

- (void) setMarkFlagged: (BOOL) markFlagged
{
	id v = [NSNumber numberWithBool:markFlagged];
	[[self propertyWithCode:'rmfl'] setTo:v];
}

- (BOOL) markRead
{
	id v = [[self propertyWithCode:'rmre'] get];
	return [v boolValue];
}

- (void) setMarkRead: (BOOL) markRead
{
	id v = [NSNumber numberWithBool:markRead];
	[[self propertyWithCode:'rmre'] setTo:v];
}

- (NSString *) playSound
{
	return [[self propertyWithCode:'rpso'] get];
}

- (void) setPlaySound: (NSString *) playSound
{
	[[self propertyWithCode:'rpso'] setTo:playSound];
}

- (NSArray *) redirectMessage
{
	return [[self propertyWithCode:'rrad'] get];
}

- (void) setRedirectMessage: (NSArray *) redirectMessage
{
	[[self propertyWithCode:'rrad'] setTo:redirectMessage];
}

- (NSString *) replyText
{
	return [[self propertyWithCode:'rrte'] get];
}

- (void) setReplyText: (NSString *) replyText
{
	[[self propertyWithCode:'rrte'] setTo:replyText];
}

- (NSURL *) runScript
{
	return [[self propertyWithCode:'rras'] get];
}

- (void) setRunScript: (NSURL *) runScript
{
	[[self propertyWithCode:'rras'] setTo:runScript];
}

- (BOOL) allConditionsMustBeMet
{
	id v = [[self propertyWithCode:'racm'] get];
	return [v boolValue];
}

- (void) setAllConditionsMustBeMet: (BOOL) allConditionsMustBeMet
{
	id v = [NSNumber numberWithBool:allConditionsMustBeMet];
	[[self propertyWithCode:'racm'] setTo:v];
}

- (MailMailbox *) copyMessage
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'rcmb'];
}

- (void) setCopyMessage: (MailMailbox *) copyMessage
{
	[[self propertyWithClass:[MailMailbox class] code:'rcmb'] setTo:copyMessage];
}

- (MailMailbox *) moveMessage
{
	return (MailMailbox *) [self propertyWithClass:[MailMailbox class] code:'rtme'];
}

- (void) setMoveMessage: (MailMailbox *) moveMessage
{
	[[self propertyWithClass:[MailMailbox class] code:'rtme'] setTo:moveMessage];
}

- (BOOL) highlightTextUsingColor
{
	id v = [[self propertyWithCode:'htuc'] get];
	return [v boolValue];
}

- (void) setHighlightTextUsingColor: (BOOL) highlightTextUsingColor
{
	id v = [NSNumber numberWithBool:highlightTextUsingColor];
	[[self propertyWithCode:'htuc'] setTo:v];
}

- (BOOL) enabled
{
	id v = [[self propertyWithCode:'isac'] get];
	return [v boolValue];
}

- (void) setEnabled: (BOOL) enabled
{
	id v = [NSNumber numberWithBool:enabled];
	[[self propertyWithCode:'isac'] setTo:v];
}

- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (void) setName: (NSString *) name
{
	[[self propertyWithCode:'pnam'] setTo:name];
}

- (BOOL) shouldCopyMessage
{
	id v = [[self propertyWithCode:'rscm'] get];
	return [v boolValue];
}

- (void) setShouldCopyMessage: (BOOL) shouldCopyMessage
{
	id v = [NSNumber numberWithBool:shouldCopyMessage];
	[[self propertyWithCode:'rscm'] setTo:v];
}

- (BOOL) shouldMoveMessage
{
	id v = [[self propertyWithCode:'rstm'] get];
	return [v boolValue];
}

- (void) setShouldMoveMessage: (BOOL) shouldMoveMessage
{
	id v = [NSNumber numberWithBool:shouldMoveMessage];
	[[self propertyWithCode:'rstm'] setTo:v];
}

- (BOOL) stopEvaluatingRules
{
	id v = [[self propertyWithCode:'rser'] get];
	return [v boolValue];
}

- (void) setStopEvaluatingRules: (BOOL) stopEvaluatingRules
{
	id v = [NSNumber numberWithBool:stopEvaluatingRules];
	[[self propertyWithCode:'rser'] setTo:v];
}



@end


@implementation MailRuleCondition


- (NSString *) expression
{
	return [[self propertyWithCode:'rexp'] get];
}

- (void) setExpression: (NSString *) expression
{
	[[self propertyWithCode:'rexp'] setTo:expression];
}

- (NSString *) header
{
	return [[self propertyWithCode:'rhed'] get];
}

- (void) setHeader: (NSString *) header
{
	[[self propertyWithCode:'rhed'] setTo:header];
}

- (MailEnrq) qualifier
{
	id v = [[self propertyWithCode:'rqua'] get];
	return [v enumCodeValue];
}

- (void) setQualifier: (MailEnrq) qualifier
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:qualifier];
	[[self propertyWithCode:'rqua'] setTo:v];
}

- (MailErut) ruleType
{
	id v = [[self propertyWithCode:'rtyp'] get];
	return [v enumCodeValue];
}

- (void) setRuleType: (MailErut) ruleType
{
	id v = [NSAppleEventDescriptor descriptorWithEnumCode:ruleType];
	[[self propertyWithCode:'rtyp'] setTo:v];
}



@end


@implementation MailRecipient


- (NSString *) address
{
	return [[self propertyWithCode:'radd'] get];
}

- (void) setAddress: (NSString *) address
{
	[[self propertyWithCode:'radd'] setTo:address];
}

- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (void) setName: (NSString *) name
{
	[[self propertyWithCode:'pnam'] setTo:name];
}



@end


@implementation MailBccRecipient



@end


@implementation MailCcRecipient



@end


@implementation MailToRecipient



@end


@implementation MailContainer



@end


@implementation MailHeader


- (NSString *) content
{
	return [[self propertyWithCode:'ctnt'] get];
}

- (void) setContent: (NSString *) content
{
	[[self propertyWithCode:'ctnt'] setTo:content];
}

- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (void) setName: (NSString *) name
{
	[[self propertyWithCode:'pnam'] setTo:name];
}



@end


@implementation MailMailAttachment


- (NSString *) name
{
	return [[self propertyWithCode:'pnam'] get];
}

- (NSString *) MIMEType
{
	return [[self propertyWithCode:'attp'] get];
}

- (NSInteger) fileSize
{
	id v = [[self propertyWithCode:'atsz'] get];
	return [v integerValue];
}

- (BOOL) downloaded
{
	id v = [[self propertyWithCode:'atdn'] get];
	return [v boolValue];
}

- (NSString *) id
{
	return [[self propertyWithCode:'ID  '] get];
}



@end


