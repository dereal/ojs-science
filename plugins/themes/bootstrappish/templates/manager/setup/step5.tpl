{**
 * templates/manager/setup/step5.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 5 of journal setup.
 *
 *}
{assign var="pageTitle" value="manager.setup.customizingTheLook"}
{include file="manager/setup/setupHeader.tpl"}

<script type="text/javascript">
{literal}
<!--

// Swap the given entries in the select field.
function swapEntries(field, i, j) {
	var tmpLabel = field.options[j].label;
	var tmpVal = field.options[j].value;
	var tmpText = field.options[j].text;
	var tmpSel = field.options[j].selected;
	field.options[j].label = field.options[i].label;
	field.options[j].value = field.options[i].value;
	field.options[j].text = field.options[i].text;
	field.options[j].selected = field.options[i].selected;
	field.options[i].label = tmpLabel;
	field.options[i].value = tmpVal;
	field.options[i].text = tmpText;
	field.options[i].selected = tmpSel;
}

// Move selected items up in the given select list.
function moveUp(field) {
	var i;
	for (i=0; i<field.length; i++) {
		if (field.options[i].selected == true && i>0) {
			swapEntries(field, i-1, i);
		}
	}
}

// Move selected items down in the given select list.
function moveDown(field) {
	var i;
	var max = field.length - 1;
	for (i = max; i >= 0; i=i-1) {
		if(field.options[i].selected == true && i < max) {
			swapEntries(field, i+1, i);
		}
	}
}

// Move selected items from select list a to select list b.
function jumpList(a, b) {
	var i;
	for (i=0; i<a.options.length; i++) {
		if (a.options[i].selected == true) {
			bMax = b.options.length;
			b.options[bMax] = new Option(a.options[i].text);
			b.options[bMax].value = a.options[i].value;
			a.options[i] = null;
			i=i-1;
		}
	}
}

function prepBlockFields() {
	var i;
	var theForm = document.getElementById('setupForm');

	theForm.elements["blockSelectLeft"].value = "";
	for (i=0; i<theForm.blockSelectLeftWidget.options.length; i++) {
		theForm.blockSelectLeft.value += encodeURI(theForm.blockSelectLeftWidget.options[i].value) + " ";
	}

	theForm.blockSelectRight.value = "";
	for (i=0; i<theForm.blockSelectRightWidget.options.length; i++) {
		theForm.blockSelectRight.value += encodeURI(theForm.blockSelectRightWidget.options[i].value) + " ";
	}

	theForm.blockUnselected.value = "";
	for (i=0; i<theForm.blockUnselectedWidget.options.length; i++) {
		theForm.blockUnselected.value += encodeURI(theForm.blockUnselectedWidget.options[i].value) + " ";
	}
	return true;
}

// -->
{/literal}
</script>

<form role="form" id="setupForm" method="post" action="{url op="saveSetup" path="5"}" enctype="multipart/form-data">
	
	{include file="common/formErrors.tpl"}

	{if count($formLocales) > 1}
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{url|assign:"setupFormUrl" op="setup" path="5" escape=false}
						{form_language_chooser form="setupForm" url=$setupFormUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			</table>
		</div>
	{/if}

	<div id="journalHomepageHeader" class="col-md-12 mag-innert-left">
		<h3>5.1 {translate key="manager.setup.journalHomepageHeader"}</h3>
		<p class="help-block">{translate key="manager.setup.journalHomepageHeaderDescription"}</p>

		<div id="journalTitleAndLogo">
			<h4>{translate key="manager.setup.journalTitle"}</h4>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%"><div class="form-group"><input type="radio" name="homeHeaderTitleType[{$formLocale|escape}]" id="homeHeaderTitleType-0" value="0"{if not $homeHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="homeHeaderTitleType-0" key="manager.setup.useTextTitle"}</div></td>
						<td width="80%" class="value"><input type="text" name="homeHeaderTitle[{$formLocale|escape}]" value="{$homeHeaderTitle[$formLocale]|escape}" size="40" maxlength="255" class="textField" /></td>
					</tr>
					<tr valign="top">
						<td width="20%"><div class="form-group"><input type="radio" name="homeHeaderTitleType[{$formLocale|escape}]" id="homeHeaderTitleType-1" value="1"{if $homeHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="homeHeaderTitleType-1" key="manager.setup.useImageTitle"}</div></td>
						<td width="80%" class="value"><input type="file" name="homeHeaderTitleImage" class="uploadField" /> <input type="submit" name="uploadHomeHeaderTitleImage" value="{translate key="common.upload"}" class="btn btn-success" /></td>
					</tr>
				</table>
			</div>

			{if $homeHeaderTitleImage[$formLocale]}
				{translate key="common.fileName"}: {$homeHeaderTitleImage[$formLocale].name|escape} {$homeHeaderTitleImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteHomeHeaderTitleImage" value="{translate key="common.delete"}" class="btn btn-danger" />
				<br />
				<img class="img-responsive" src="{$publicFilesDir}/{$homeHeaderTitleImage[$formLocale].uploadName|escape:"url"}" width="{$homeHeaderTitleImage[$formLocale].width|escape}" height="{$homeHeaderTitleImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.homePageHeader.altText"}" />
				<br />
				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr valign="top">
							<td width="20%">{fieldLabel name="homeHeaderTitleImageAltText" key="common.altText"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" name="homeHeaderTitleImageAltText[{$formLocale|escape}]" value="{$homeHeaderTitleImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="form-control" /></div></td>
						</tr>
						<tr valign="top">
							<td>&nbsp;</td>
							<td class="value"><p class="help-block">{translate key="common.altTextInstructions"}</p></td>
						</tr>
					</table>
				</div>
			{/if}
		</div>

		<div id="journalLogoImage">
			<h4>{translate key="manager.setup.journalLogo"}</h4>
			
			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{translate key="manager.setup.useImageLogo"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="file" name="homeHeaderLogoImage" class="form-control" /></div> <input type="submit" name="uploadHomeHeaderLogoImage" value="{translate key="common.upload"}" class="btn btn-success" /></td>
					</tr>
				</table>
			</div>

			{if $homeHeaderLogoImage[$formLocale]}
				{translate key="common.fileName"}: {$homeHeaderLogoImage[$formLocale].name|escape} {$homeHeaderLogoImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteHomeHeaderLogoImage" value="{translate key="common.delete"}" class="btn btn-danger" />
				<br />
				<img class="img-responsive" src="{$publicFilesDir}/{$homeHeaderLogoImage[$formLocale].uploadName|escape:"url"}" width="{$homeHeaderLogoImage[$formLocale].width|escape}" height="{$homeHeaderLogoImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.homePageHeaderLogo.altText"}" />
				<br />
				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr valign="top">
							<td width="20%">{fieldLabel name="homeHeaderLogoImageAltText" key="common.altText"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" name="homeHeaderLogoImageAltText[{$formLocale|escape}]" value="{$homeHeaderLogoImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="form-control" /></div></td>
						</tr>
						<tr valign="top">
							<td>&nbsp;</td>
							<td class="value"><p class="help-block">{translate key="common.altTextInstructions"}</p></td>
						</tr>
					</table>
				</div>
			{/if}
		</div>

		<div id="journalThumbnail">
			<h4>{translate key="manager.setup.journalThumbnail"}</h4>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{translate key="manager.setup.useThumbnail"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="file" name="journalThumbnail" class="form-control" /></div> <input type="submit" name="uploadJournalThumbnail" value="{translate key="common.upload"}" class="btn btn-success" /></td>
					</tr>
				</table>
			</div>

			{if $journalThumbnail[$formLocale]}
				{translate key="common.fileName"}: {$journalThumbnail[$formLocale].name|escape} {$journalThumbnail[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteJournalThumbnail" value="{translate key="common.delete"}" class="btn btn-danger" />
				<br />
				<img class="img-responsive" src="{$publicFilesDir}/{$journalThumbnail[$formLocale].uploadName|escape:"url"}" width="{$journalThumbnail[$formLocale].width|escape}" height="{$journalThumbnail[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.journalThumbnail.altText"}" />
				<br />
				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr valign="top">
							<td width="20%">{fieldLabel name="journalThumbnailAltText" key="common.altText"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" name="journalThumbnailAltText[{$formLocale|escape}]" value="{$journalThumbnailAltText[$formLocale]|escape}" size="40" maxlength="255" class="form-control" /></div></td>
						</tr>
						<tr valign="top">
							<td>&nbsp;</td>
							<td class="value"><p class="help-block">{translate key="common.altTextInstructions"}</p></td>
						</tr>
					</table>
				</div>
			{/if}
		</div>
	</div>

	<div class="separator"></div>

	<div id="journalHomepageContent" class="col-md-12 mag-innert-left">
		<h3>5.2 {translate key="manager.setup.journalHomepageContent"}</h3>
		<p class="help-block">{translate key="manager.setup.journalHomepageContentDescription"}</p>
	</div>

	<div id="journalDescription" class="col-md-12 mag-innert-left">
		<h4>{translate key="manager.setup.journalDescription"}</h4>
		<p class="help-block">{translate key="manager.setup.journalDescriptionDescription"}</p>

		<p><div class="form-group"><textarea id="description" name="description[{$formLocale|escape}]" rows="3" cols="60" class="form-control">{$description[$formLocale]|escape}</textarea></div></p>
	</div>

	<div id="homepageImage" class="col-md-12 mag-innert-left">
		<h4>{translate key="manager.setup.homepageImage"}</h4>
		<p class="help-block">{translate key="manager.setup.homepageImageDescription"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{translate key="manager.setup.homepageImage"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="file" name="homepageImage" class="form-control" /></div> <input type="submit" name="uploadHomepageImage" value="{translate key="common.upload"}" class="btn btn-success" /></td>
				</tr>
			</table>
		</div>

		{if $homepageImage[$formLocale]}
			{translate key="common.fileName"}: {$homepageImage[$formLocale].name|escape} {$homepageImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteHomepageImage" value="{translate key="common.delete"}" class="btn btn-danger" />
			<br />
			<img class="img-responsive" src="{$publicFilesDir}/{$homepageImage[$formLocale].uploadName|escape:"url"}" width="{$homepageImage[$formLocale].width|escape}" height="{$homepageImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.journalHomepageImage.altText"}" />
			<br />
			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{fieldLabel name="homepageImageAltText" key="common.altText"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" name="homepageImageAltText[{$formLocale|escape}]" value="{$homepageImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td>&nbsp;</td>
						<td class="value"><p class="help-block">{translate key="common.altTextInstructions"}</p></td>
					</tr>
				</table>
			</div>
		{/if}

		<div id="currentIssue">
			<h4>{translate key="manager.setup.currentIssue"}</h4>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="5%"><div class="form-group"><input type="checkbox" name="displayCurrentIssue" id="displayCurrentIssue" value="1" {if $displayCurrentIssue} checked="checked"{/if} /></div></td>
						<td width="95%" class="value"><label class="control-label" for="displayCurrentIssue">{translate key="manager.setup.displayCurrentIssue"}</label></td>
					</tr>
				</table>
			</div>
		</div>

		<div id="additionalContent">
			<h4>{translate key="manager.setup.additionalContent"}</h4>
			<p class="help-block">{translate key="manager.setup.additionalContentDescription"}</p>

			<p><div class="form-group"><textarea name="additionalHomeContent[{$formLocale|escape}]" id="additionalHomeContent" rows="12" cols="60" class="form-control">{$additionalHomeContent[$formLocale]|escape}</textarea></div></p>
		</div>
	</div>

	<div class="separator"></div>

	<div id="journalPageHeaderInfo" class="col-md-12 mag-innert-left">
		<h3>5.3 {translate key="manager.setup.journalPageHeader"}</h3>
		<p class="help-block">{translate key="manager.setup.journalPageHeaderDescription"}</p>

		<div id="pageHeaderTitle">
			<h4>{translate key="manager.setup.journalTitle"}</h4>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%"><div class="form-group"><input type="radio" name="pageHeaderTitleType[{$formLocale|escape}]" id="pageHeaderTitleType-0" value="0"{if not $pageHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="pageHeaderTitleType-0" key="manager.setup.useTextTitle"}</div></td>
						<td width="80%" class="value"><div class="form-group"><input type="text" name="pageHeaderTitle[{$formLocale|escape}]" value="{$pageHeaderTitle[$formLocale]|escape}" size="40" maxlength="255" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%"><div class="form-group"><input type="radio" name="pageHeaderTitleType[{$formLocale|escape}]" id="pageHeaderTitleType-1" value="1"{if $pageHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="pageHeaderTitleType-1" key="manager.setup.useImageTitle"}</div></td>
						<td width="80%" class="value"><div class="form-group"><input type="file" name="pageHeaderTitleImage" class="form-control" /></div> <input type="submit" name="uploadPageHeaderTitleImage" value="{translate key="common.upload"}" class="btn btn-success" /></td>
					</tr>
				</table>
			</div>

			{if $pageHeaderTitleImage[$formLocale]}
				{translate key="common.fileName"}: {$pageHeaderTitleImage[$formLocale].name|escape} {$pageHeaderTitleImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deletePageHeaderTitleImage" value="{translate key="common.delete"}" class="btn btn-danger" />
				<br />
				<img class="img-responsive" src="{$publicFilesDir}/{$pageHeaderTitleImage[$formLocale].uploadName|escape:"url"}" width="{$pageHeaderTitleImage[$formLocale].width|escape}" height="{$pageHeaderTitleImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.pageHeader.altText"}" />
				<br />
				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr valign="top">
							<td width="20%">{fieldLabel name="pageHeaderTitleImageAltText" key="common.altText"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" name="pageHeaderTitleImageAltText[{$formLocale|escape}]" value="{$pageHeaderTitleImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="form-control" /></div></td>
						</tr>
						<tr valign="top">
							<td>&nbsp;</td>
							<td class="value"><p class="help-block">{translate key="common.altTextInstructions"}</p></td>
						</tr>
					</table>
				</div>
			{/if}
		</div>

		<div id="journalLogo">
			<h4>{translate key="manager.setup.journalLogo"}</h4>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{translate key="manager.setup.useImageLogo"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="file" name="pageHeaderLogoImage" class="form-control" /></div> <input type="submit" name="uploadPageHeaderLogoImage" value="{translate key="common.upload"}" class="btn btn-success" /></td>
					</tr>
				</table>
			</div>

			{if $pageHeaderLogoImage[$formLocale]}
				{translate key="common.fileName"}: {$pageHeaderLogoImage[$formLocale].name|escape} {$pageHeaderLogoImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deletePageHeaderLogoImage" value="{translate key="common.delete"}" class="btn btn-danger" />
				<br />
				<img class="img-responsive" src="{$publicFilesDir}/{$pageHeaderLogoImage[$formLocale].uploadName|escape:"url"}" width="{$pageHeaderLogoImage[$formLocale].width|escape}" height="{$pageHeaderLogoImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.pageHeaderLogo.altText"}" />
				<br />
				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr valign="top">
							<td width="20%">{fieldLabel name="pageHeaderLogoImageAltText" key="common.altText"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" name="pageHeaderLogoImageAltText[{$formLocale|escape}]" value="{$pageHeaderLogoImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="form-control" /></div></td>
						</tr>
						<tr valign="top">
							<td>&nbsp;</td>
							<td class="value"><p class="help-block">{translate key="common.altTextInstructions"}</p></td>
							</tr>
					</table>
				</div>
			{/if}
		</div>

		<div id="journalFavicon">
			<h4>{translate key="manager.setup.journalFavicon"}</h4>
			<p class="help-block">{translate key="manager.setup.journalFaviconDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{translate key="manager.setup.useImageLogo"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="file" name="journalFavicon" class="form-control" /></div> <input type="submit" name="uploadJournalFavicon" value="{translate key="common.upload"}" class="btn btn-success" /></td>
					</tr>
				</table>
			</div>

			{if $journalFavicon[$formLocale]}
				{translate key="common.fileName"}: {$journalFavicon[$formLocale].name|escape} {$journalFavicon[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteJournalFavicon" value="{translate key="common.delete"}" class="btn btn-danger" />
				<br />
				<img class="img-responsive" src="{$publicFilesDir}/{$journalFavicon[$formLocale].uploadName|escape:"url"}" width="16px" height="16px" style="border: 0;" alt="favicon" />
			{/if}
		</div>

		<div id="alternateHeader">
			<h4>{translate key="manager.setup.alternateHeader"}</h4>
			<p class="help-block">{translate key="manager.setup.alternateHeaderDescription"}</p>

			<p><div class="form-group"><textarea name="journalPageHeader[{$formLocale|escape}]" id="journalPageHeader" rows="12" cols="60" class="form-control">{$journalPageHeader[$formLocale]|escape}</textarea></div></p>
		</div>
	</div>

	<div class="separator"></div>

	<div id="journalPageFooterInfo" class="col-md-12 mag-innert-left">
		<h3>5.4 {translate key="manager.setup.journalPageFooter"}</h3>
		<p class="help-block">{translate key="manager.setup.journalPageFooterDescription"}</p>

		<p><div class="form-group"><textarea name="journalPageFooter[{$formLocale|escape}]" id="journalPageFooter" rows="12" cols="60" class="form-control">{$journalPageFooter[$formLocale]|escape}</textarea></div></p>
	</div>

	<div class="separator"></div>

	<div id="navigationBar" class="col-md-12 mag-innert-left">
		<h3>5.5 {translate key="manager.setup.navigationBar"}</h3>
		<p class="help-block">{translate key="manager.setup.itemsDescription"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				{foreach name=navItems from=$navItems[$formLocale] key=navItemId item=navItem}
					<tr valign="top">
						<td width="20%">{fieldLabel name="navItems-$navItemId-name" key="manager.setup.labelName"}</td>
						<td width="80%" class="value">
							<div class="form-group"><input type="text" name="navItems[{$formLocale|escape}][{$navItemId|escape}][name]" id="navItems-{$navItemId|escape}-name" value="{$navItem.name|escape}" size="30" maxlength="90" class="form-control" /></div> <input type="submit" name="delNavItem[{$navItemId|escape}]" value="{translate key="common.delete"}" class="btn btn-danger" />
							<table class="table table-striped" width="100%">
								<tr valign="top">
									<td width="5%"><div class="form-group"><input type="checkbox" name="navItems[{$formLocale|escape}][{$navItemId|escape}][isLiteral]" id="navItems-{$navItemId|escape}-isLiteral" value="1"{if $navItem.isLiteral} checked="checked"{/if} /></div></td>
									<td width="95%"><label class="control-label" for="navItems-{$navItemId|escape}-isLiteral">{translate key="manager.setup.navItemIsLiteral"}</label></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="navItems-$navItemId-url" key="common.url"}</td>
						<td width="80%" class="value">
							<div class="form-group"><input type="text" name="navItems[{$formLocale|escape}][{$navItemId|escape}][url]" id="navItems-{$navItemId|escape}-url" value="{$navItem.url|escape}" size="60" maxlength="255" class="form-control" /></div>
							<div class="table-responsive">
								<table class="table table-striped" width="100%">
									<tr valign="top">
										<td width="5%"><div class="form-group"><input type="checkbox" name="navItems[{$formLocale|escape}][{$navItemId|escape}][isAbsolute]" id="navItems-{$navItemId|escape}-isAbsolute" value="1"{if $navItem.isAbsolute} checked="checked"{/if} /></div></td>
										<td width="95%"><label class="control-label" for="navItems-{$navItemId|escape}-isAbsolute">{translate key="manager.setup.navItemIsAbsolute"}</label></td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					{if !$smarty.foreach.navItems.last}
						<tr valign="top">
							<td colspan="2" class="separator">&nbsp;</td>
						</tr>
					{/if}
				{foreachelse}
					<tr valign="top">
						<td width="20%">{fieldLabel name="navItems-0-name" key="manager.setup.labelName"}</td>
						<td width="80%" class="value">
							<div class="form-group"><input type="text" name="navItems[{$formLocale|escape}][0][name]" id="navItems-0-name" size="30" maxlength="90" class="form-control" /></div>
							<table class="table table-striped" width="100%">
								<tr valign="top">
									<td width="5%"><div class="form-group"><input type="checkbox" name="navItems[{$formLocale|escape}][0][isLiteral]" id="navItems-0-isLiteral" value="1" /></div></td>
									<td width="95%"><label class="control-label" for="navItems-0-isLiteral">{translate key="manager.setup.navItemIsLiteral"}</label></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="navItems-0-url" key="common.url"}</td>
						<td width="80%" class="value">
							<div class="form-group"><input type="text" name="navItems[{$formLocale|escape}][0][url]" id="navItems-0-url" size="60" maxlength="255" class="form-control" /></div>
							<table class="table table-striped" width="100%">
								<tr valign="top">
									<td width="5%"><div class="form-group"><input type="checkbox" name="navItems[{$formLocale|escape}][0][isAbsolute]" id="navItems-0-isAbsolute" value="1" /></div></td>
									<td width="95%"><label class="control-label" for="navItems-0-isAbsolute">{translate key="manager.setup.navItemIsAbsolute"}</label></td>
								</tr>
							</table>
						</td>
					</tr>
				{/foreach}
			</table>
		</div>

		<p><input type="submit" name="addNavItem" value="{translate key="manager.setup.addNavItem"}" class="btn btn-success" /></p>
	</div>

	<div class="separator"></div>

	<div id="journalLayout" class="col-md-12 mag-innert-left">
		<h3>5.6 {translate key="manager.setup.journalLayout"}</h3>
		<p class="help-block">{translate key="manager.setup.journalLayoutDescription"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr>
					<td width="20%"><label class="control-label" for="journalTheme">{translate key="manager.setup.journalTheme"}</label></td>
					<td width="80%" class="value">
						<div class="form-group">
							<select name="journalTheme" class="form-control" id="journalTheme"{if empty($journalThemes)} disabled="disabled"{/if}>
								<option value="">{translate key="common.none"}</option>
								{foreach from=$journalThemes key=path item=journalThemePlugin}
									<option value="{$path|escape}"{if $path == $journalTheme} selected="selected"{/if}>{$journalThemePlugin->getDisplayName()|escape}</option>
								{/foreach}
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td width="20%"><label class="control-label" for="journalStyleSheet">{translate key="manager.setup.useJournalStyleSheet"}</label></td>
					<td width="80%" class="value"><div class="form-group"><input type="file" name="journalStyleSheet" id="journalStyleSheet" class="form-control" /></div> <input type="submit" name="uploadJournalStyleSheet" value="{translate key="common.upload"}" class="btn btn-success" /></td>
				</tr>
			</table>
		</div>

		{if $journalStyleSheet}
			{translate key="common.fileName"}: <a href="{$publicFilesDir}/{$journalStyleSheet.uploadName|escape:"url"}" class="file">{$journalStyleSheet.name|escape}</a> {$journalStyleSheet.dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteJournalStyleSheet" value="{translate key="common.delete"}" class="btn btn-danger" />
		{/if}

		<div class="table-responsive">
			<table class="table table-striped" border="0" align="center">
				<tr align="center">
					<td rowspan="2">
						{translate key="manager.setup.layout.leftSidebar"}<br/>
						<input class="btn btn-success" style="width: 130px;" type="button" value="&uarr;" onclick="moveUp(this.form.elements['blockSelectLeftWidget']);" /><br/>
						<div class="form-group">
							<select name="blockSelectLeftWidget" multiple="multiple" size="10" class="form-control" style="width: 130px; height:200px">
								{foreach from=$leftBlockPlugins item=block}
									<option value="{$block->getName()|escape}">{$block->getDisplayName()|escape}</option>
								{foreachelse}
									<option value=""></option>
								{/foreach}
							</select><br/>
						</div>
						<input class="btn btn-success" style="width: 130px;" type="button" value="&darr;" onclick="moveDown(this.form.elements['blockSelectLeftWidget']);" />
					</td>
					<td>
						<input class="btn btn-warning" style="width: 30px;" type="button" value="&larr;" onclick="jumpList(this.form.elements['blockUnselectedWidget'],this.form.elements['blockSelectLeftWidget']);" /><br/>
						<input class="btn btn-success" style="width: 30px;" type="button" value="&rarr;" onclick="jumpList(this.form.elements['blockSelectLeftWidget'],this.form.elements['blockUnselectedWidget']);" />
					</td>
					<td valign="top">
						{translate key="manager.setup.layout.unselected"}<br/>
						<div class="form-group">
							<select name="blockUnselectedWidget" multiple="multiple" size="10" class="form-control" style="width: 120px; height:180px;" >
								{foreach from=$disabledBlockPlugins item=block}
									<option value="{$block->getName()|escape}">{$block->getDisplayName()|escape}</option>
								{foreachelse}
									<option value=""></option>
								{/foreach}
							</select>
						</div>
					</td>
					<td>
						<input class="btn btn-success" style="width: 30px;" type="button" value="&larr;" onclick="jumpList(this.form.elements['blockSelectRightWidget'],this.form.elements['blockUnselectedWidget']);" /><br/>
						<input class="btn btn-warning" style="width: 30px;" type="button" value="&rarr;" onclick="jumpList(this.form.elements['blockUnselectedWidget'],this.form.elements['blockSelectRightWidget']);" />
					</td>
					<td rowspan="2">
						{translate key="manager.setup.layout.rightSidebar"}<br/>
						<input class="btn btn-success" style="width: 130px;" type="button" value="&uarr;" onclick="moveUp(this.form.elements['blockSelectRightWidget']);" /><br/>
						<div class="form-group">
							<select name="blockSelectRightWidget" multiple="multiple" size="10" class="form-control" style="width: 130px; height:200px" >
								{foreach from=$rightBlockPlugins item=block}
									<option value="{$block->getName()|escape}">{$block->getDisplayName()|escape}</option>
								{foreachelse}
									<option value=""></option>
								{/foreach}
							</select><br/>
						</div>
						<input class="btn btn-success" style="width: 130px;" type="button" value="&darr;" onclick="moveDown(this.form.elements['blockSelectRightWidget']);" />
					</td>
				</tr>
				<tr align="center">
					<td colspan="3" valign="top" height="60px">
						<input class="btn btn-success" style="width: 190px;" type="button" value="&larr;" onclick="jumpList(this.form.elements['blockSelectRightWidget'],this.form.elements['blockSelectLeftWidget']);" /><br/>
						<input class="btn btn-success" style="width: 190px;" type="button" value="&rarr;" onclick="jumpList(this.form.elements['blockSelectLeftWidget'],this.form.elements['blockSelectRightWidget']);" />
					</td>
				</tr>
			</table>
		</div>
		
		<input type="hidden" name="blockSelectLeft" value="" />
		<input type="hidden" name="blockSelectRight" value="" />
		<input type="hidden" name="blockUnselected" value="" />
	</div>

	<div class="separator"></div>

	<div id="setupInfo" class="col-md-12 mag-innert-left">
		<h3>5.7 {translate key="manager.setup.information"}</h3>
		<p class="help-block">{translate key="manager.setup.information.description"}</p>

		<div id="infoForReaders">
			<h4>{translate key="manager.setup.information.forReaders"}</h4>
		
			<p><div class="form-group"><textarea name="readerInformation[{$formLocale|escape}]" id="readerInformation" rows="12" cols="60" class="form-control">{$readerInformation[$formLocale]|escape}</textarea></div></p>
		</div>

		<div id="infoForAuth">
			<h4>{translate key="manager.setup.information.forAuthors"}</h4>

			<p><div class="form-group"><textarea name="authorInformation[{$formLocale|escape}]" id="authorInformation" rows="12" cols="60" class="form-control">{$authorInformation[$formLocale]|escape}</textarea></div></p>
		</div>

		<div id="infoForLibs">
			<h4>{translate key="manager.setup.information.forLibrarians"}</h4>

			<p><div class="form-group"><textarea name="librarianInformation[{$formLocale|escape}]" id="librarianInformation" rows="12" cols="60" class="form-control">{$librarianInformation[$formLocale]|escape}</textarea></div></p>
		</div>
	</div>

	<div class="separator"></div>

	<div id="lists" class="col-md-12 mag-innert-left">
		<h3>5.8 {translate key="manager.setup.lists"}</h3>
		<p class="help-block">{translate key="manager.setup.listsDescription"}</p>
		
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{translate key="manager.setup.itemsPerPage"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" size="3" name="itemsPerPage" class="form-control" value="{$itemsPerPage|escape}" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{translate key="manager.setup.numPageLinks"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" size="3" name="numPageLinks" class="form-control" value="{$numPageLinks|escape}" /></div></td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	<p><input type="submit" onclick="prepBlockFields()" value="{translate key="common.saveAndContinue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="setup" escape=false}'" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{include file="common/footer.tpl"}