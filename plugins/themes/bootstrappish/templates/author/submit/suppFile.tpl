{**
 * templates/author/submit/suppFile.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Add/edit a supplementary file.
 *
 *}
{assign var="pageTitle" value="author.submit.step4a"}
{include file="author/submit/submitHeader.tpl"}

<p><a href="{url op="submit" path=4 articleId=$articleId}">&lt;&lt; {translate key="author.submit.backToSupplementaryFiles"}</a></p>

<br/>

<form role="form" id="submit" method="post" action="{url op="saveSubmitSuppFile" path=$suppFileId}" enctype="multipart/form-data">
	<input type="hidden" name="articleId" value="{$articleId|escape}" />
	
	{include file="common/formErrors.tpl"}

	{if count($formLocales) > 1}
		<div id="locale" class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{url|assign:"submitFormUrl" path=$suppFileId articleId=$articleId escape=false}
						{form_language_chooser form="submit" url=$submitFormUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			</table>
		</div>
	{/if}
	
	<div id="supplementaryFileData" class="col-md-12 mag-innert-left">
		<h3>{translate key="author.submit.supplementaryFileData"}</h3>
		<p class="help-block">{translate key="author.submit.supplementaryFileDataDescription"}</p>

		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr valign="top">
					<td width="20%">{fieldLabel required="true" name="title" key="common.title"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="60" maxlength="255" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="creator" key="author.submit.suppFile.createrOrOwner"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="creator[{$formLocale|escape}]" class="form-control" id="creator" value="{$creator[$formLocale]|escape}" size="60" maxlength="255" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="subject" key="common.keywords"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="subject[{$formLocale|escape}]" class="form-control" id="subject" value="{$subject[$formLocale]|escape}" size="60" maxlength="255" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="type" key="common.type"}</td>
					<td width="80%" class="value"><div class="form-group"><select name="type" class="form-control" id="type" size="1">{html_options_translate output=$typeOptionsOutput values=$typeOptionsValues translateValues="true" selected=$type}</select><br /><label class="control-label">{translate key="author.submit.suppFile.specifyOtherType"}</label> <input type="text" name="typeOther[{$formLocale|escape}]" id="typeOther" class="form-control" value="{$typeOther[$formLocale]|escape}" size="45" maxlength="255" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="description" key="author.submit.suppFile.briefDescription"}</td>
					<td width="80%" class="value"><div class="form-group"><textarea name="description[{$formLocale|escape}]" class="form-control" id="description" rows="5" cols="60">{$description[$formLocale]|escape}</textarea></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="publisher" key="common.publisher"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="publisher[{$formLocale|escape}]" class="form-control" id="publisher" value="{$publisher[$formLocale]|escape}" size="60" maxlength="255" /></div></td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td><p class="help-block">{translate key="author.submit.suppFile.publisherDescription"}</p></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="sponsor" key="author.submit.suppFile.contributorOrSponsor"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="sponsor[{$formLocale|escape}]" class="form-control" id="sponsor" value="{$sponsor[$formLocale]|escape}" size="60" maxlength="255" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="dateCreated" key="common.date"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="dateCreated" class="form-control" id="dateCreated" value="{$dateCreated|escape}" size="11" maxlength="10" /> <p class="help-block">{translate key="submission.date.yyyymmdd"}</p></div></td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td><p class="help-block">{translate key="author.submit.suppFile.dateDescription"}</p></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="source" key="common.source"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="source[{$formLocale|escape}]" class="form-control" id="source" value="{$source[$formLocale]|escape}" size="60" maxlength="255" /></div></td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td><p class="help-block">{translate key="author.submit.suppFile.sourceDescription"}</p></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="language" key="common.language"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="language" class="form-control" id="language" value="{$language|escape}" size="5" maxlength="10" /></div></td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td><p class="help-block">{translate key="author.submit.languageInstructions"}</p></td>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="separator"></div>

	{call_hook name="Templates::Author::Submit::SuppFile::AdditionalMetadata"}

	<div id="supplementaryFileUpload" class="col-md-12 mag-innert-left">
		<h3>{translate key="author.submit.supplementaryFileUpload"}</h3>

		<div class="table-responsive">
			<table id="suppFile" class="table table-striped" width="100%">
				{if $suppFile && $suppFile->getFileId()}
					<tr valign="top">
						<td width="20%">{translate key="common.fileName"}</td>
						<td width="80%" class="value"><a href="{url op="download" path=$articleId|to_array:$suppFile->getFileId()}">{$suppFile->getFileName()|escape}</a></td>
					</tr>
					<tr valign="top">
						<td width="20%">{translate key="common.originalFileName"}</td>
						<td width="80%" class="value">{$suppFile->getOriginalFileName()|escape}</td>
					</tr>
					<tr valign="top">
						<td width="20%">{translate key="common.fileSize"}</td>
						<td width="80%" class="value">{$suppFile->getNiceFileSize()}</td>
					</tr>
					<tr valign="top">
						<td width="20%">{translate key="common.dateUploaded"}</td>
						<td width="80%" class="value">{$suppFile->getDateUploaded()|date_format:$datetimeFormatShort}</td>
					</tr>
			</table>
		</div>

		<div class="table-responsive">
			<table id="showReviewers" class="table table-striped" width="100%">
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<div class="form-group">
							<input type="checkbox" name="showReviewers" id="showReviewers" value="1"{if $showReviewers==1} checked="checked"{/if} />
							<label class="control-label">{translate key="author.submit.suppFile.availableToPeers"}</label>
						</div>
					</td>
				</tr>
			</table>
		</div>
		{else}
			<tr valign="top">
				<td colspan="2" class="nodata"><p class="help-block">{translate key="author.submit.suppFile.noFile"}</p></td>
			</tr>
		</table>
	</div>
	{/if}

	<div class="separator"></div>

	<div class="table-responsive">
		<table id="replaceFile" class="table table-striped" width="100%">
			<tr valign="top">
				<td width="20%">
					{if $suppFile && $suppFile->getFileId()}
						{fieldLabel name="uploadSuppFile" key="common.replaceFile"}
					{else}
						{fieldLabel name="uploadSuppFile" key="common.upload"}
					{/if}
				</td>
				<td width="80%" class="value"><div class="form-group"><input type="file" name="uploadSuppFile" id="uploadSuppFile" class="form-control" />&nbsp;&nbsp;{translate key="form.saveToUpload"}</div></td>
			</tr>
			{if not ($suppFile && $suppFile->getFileId())}
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<div class="form-group">
							<input type="checkbox" name="showReviewers" id="showReviewers" value="1"{if $showReviewers==1} checked="checked"{/if} />&nbsp;
							<label class="control-label">{translate key="author.submit.suppFile.availableToPeers"}</label>
						</div>
					</td>
				</tr>
			{/if}
		</table>
	</div>
	</div>
	
	<div class="separator"></div>

	<p><input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="submit" path="4" articleId=$articleId escape=false}'" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{include file="common/footer.tpl"}