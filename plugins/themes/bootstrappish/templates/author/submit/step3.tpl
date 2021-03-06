{**
 * templates/author/submit/step3.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 3 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step3"}
{include file="author/submit/submitHeader.tpl"}

{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}

<div class="separator"></div>

<form role="form" id="submit" method="post" action="{url op="saveSubmit" path=$submitStep}">
	<input type="hidden" name="articleId" value="{$articleId|escape}" />
	
	{include file="common/formErrors.tpl"}

	<script type="text/javascript">
	{literal}
	<!--
	// Move author up/down
	function moveAuthor(dir, authorIndex) {
		var form = document.getElementById('submit');
		form.moveAuthor.value = 1;
		form.moveAuthorDir.value = dir;
		form.moveAuthorIndex.value = authorIndex;
		form.submit();
	}
	// -->
	{/literal}
	</script>

	{if count($formLocales) > 1}
		<div id="locales" class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{url|assign:"submitFormUrl" op="submit" path="3" articleId=$articleId escape=false}
						{* Maintain localized author info across requests *}
						{foreach from=$authors key=authorIndex item=author}
							{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
								{foreach from=$author.competingInterests key="thisLocale" item="thisCompetingInterests"}
									{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][competingInterests][{$thisLocale|escape}]" value="{$thisCompetingInterests|escape}" />{/if}
								{/foreach}
							{/if}
							{foreach from=$author.biography key="thisLocale" item="thisBiography"}
								{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][biography][{$thisLocale|escape}]" value="{$thisBiography|escape}" />{/if}
							{/foreach}
							{foreach from=$author.affiliation key="thisLocale" item="thisAffiliation"}
								{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][affiliation][{$thisLocale|escape}]" value="{$thisAffiliation|escape}" />{/if}
							{/foreach}
						{/foreach}
						{form_language_chooser form="submit" url=$submitFormUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			</table>
		</div>
	{/if}

	<div id="authors" class="col-md-12 mag-innert-left">
		<h3>{translate key="article.authors"}</h3>
		<input type="hidden" name="deletedAuthors" value="{$deletedAuthors|escape}" />
		<input type="hidden" name="moveAuthor" value="0" />
		<input type="hidden" name="moveAuthorDir" value="" />
		<input type="hidden" name="moveAuthorIndex" value="" />

		{foreach name=authors from=$authors key=authorIndex item=author}
			<input type="hidden" name="authors[{$authorIndex|escape}][authorId]" value="{$author.authorId|escape}" />
			<input type="hidden" name="authors[{$authorIndex|escape}][seq]" value="{$authorIndex+1}" />
			{if $smarty.foreach.authors.total <= 1}
				<input type="hidden" name="primaryContact" value="{$authorIndex|escape}" />
			{/if}

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-$authorIndex-firstName" required="true" key="user.firstName"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[{$authorIndex|escape}][firstName]" id="authors-{$authorIndex|escape}-firstName" value="{$author.firstName|escape}" size="20" maxlength="40" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-$authorIndex-middleName" key="user.middleName"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[{$authorIndex|escape}][middleName]" id="authors-{$authorIndex|escape}-middleName" value="{$author.middleName|escape}" size="20" maxlength="40" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-$authorIndex-lastName" required="true" key="user.lastName"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[{$authorIndex|escape}][lastName]" id="authors-{$authorIndex|escape}-lastName" value="{$author.lastName|escape}" size="20" maxlength="90" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-$authorIndex-email" required="true" key="user.email"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[{$authorIndex|escape}][email]" id="authors-{$authorIndex|escape}-email" value="{$author.email|escape}" size="30" maxlength="90" /></div></td>
					</tr>
					<tr valign="top">
						<td>{fieldLabel name="authors-$authorIndex-url" key="user.url"}</td>
						<td class="value"><div class="form-group"><input type="text" name="authors[{$authorIndex|escape}][url]" id="authors-{$authorIndex|escape}-url" value="{$author.url|escape}" size="30" maxlength="90" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-$authorIndex-affiliation" key="user.affiliation"}</td>
						<td width="80%" class="value">
							<div class="form-group">
								<textarea name="authors[{$authorIndex|escape}][affiliation][{$formLocale|escape}]" class="form-control" id="authors-{$authorIndex|escape}-affiliation" rows="5" cols="40">{$author.affiliation[$formLocale]|escape}</textarea>
								<p class="help-block">{translate key="user.affiliation.description"}</p>
							</div>
						</td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-$authorIndex-country" key="common.country"}</td>
						<td width="80%" class="value">
							<div class="form-group">
								<select name="authors[{$authorIndex|escape}][country]" id="authors-{$authorIndex|escape}-country" class="form-control">
									<option value=""></option>
									{html_options options=$countries selected=$author.country}
								</select>
							</div>
						</td>
					</tr>
					{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
						<tr valign="top">
							<td width="20%">{fieldLabel name="authors-$authorIndex-competingInterests" key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}</td>
							<td width="80%" class="value"><div class="form-group"><textarea name="authors[{$authorIndex|escape}][competingInterests][{$formLocale|escape}]" class="form-control" id="authors-{$authorIndex|escape}-competingInterests" rows="5" cols="40">{$author.competingInterests[$formLocale]|escape}</textarea></div></td>
						</tr>
					{/if}{* requireAuthorCompetingInterests *}
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-$authorIndex-biography" key="user.biography"}<br />{translate key="user.biography.description"}</td>
						<td width="80%" class="value"><div class="form-group"><textarea name="authors[{$authorIndex|escape}][biography][{$formLocale|escape}]" class="form-control" id="authors-{$authorIndex|escape}-biography" rows="5" cols="40">{$author.biography[$formLocale]|escape}</textarea></div></td>
					</tr>

					{call_hook name="Templates::Author::Submit::Authors"}

					{if $smarty.foreach.authors.total > 1}
						<tr valign="top">
							<td colspan="2">
								<a href="javascript:moveAuthor('u', '{$authorIndex|escape}')" class="action">&uarr;</a> <a href="javascript:moveAuthor('d', '{$authorIndex|escape}')" class="action">&darr;</a>
								{translate key="author.submit.reorderInstructions"}
							</td>
						</tr>
						<tr valign="top">
							<td width="80%" class="value" colspan="2"><div class="form-group"><input type="radio" name="primaryContact" value="{$authorIndex|escape}"{if $primaryContact == $authorIndex} checked="checked"{/if} /> <label class="control-label" for="primaryContact">{translate key="author.submit.selectPrincipalContact"}</label> </div><input type="submit" name="delAuthor[{$authorIndex|escape}]" value="{translate key="author.submit.deleteAuthor"}" class="btn btn-warning" /></td>
						</tr>
						<tr>
							<td colspan="2"><br/></td>
						</tr>
					{/if}
				</table>
			</div>
		{foreachelse}
			<input type="hidden" name="authors[0][authorId]" value="0" />
			<input type="hidden" name="primaryContact" value="0" />
			<input type="hidden" name="authors[0][seq]" value="1" />
			
			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-0-firstName" required="true" key="user.firstName"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][firstName]" id="authors-0-firstName" size="20" maxlength="40" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-0-middleName" key="user.middleName"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][middleName]" id="authors-0-middleName" size="20" maxlength="40" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-0-lastName" required="true" key="user.lastName"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][lastName]" id="authors-0-lastName" size="20" maxlength="90" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-0-affiliation" key="user.affiliation"}</td>
						<td width="80%" class="value">
							<div class="form-group">
								<textarea name="authors[0][affiliation][{$formLocale|escape}]" class="form-control" id="authors-0-affiliation" rows="5" cols="40"></textarea><br/>
								<p class="help-block">{translate key="user.affiliation.description"}</p>
							</div>
						</td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-0-country" key="common.country"}</td>
						<td width="80%" class="value">
							<div class="form-group">
								<select name="authors[0][country]" id="authors-0-country" class="form-control">
									<option value=""></option>
									{html_options options=$countries}
								</select>
							</div>
						</td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-0-email" required="true" key="user.email"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][email]" id="authors-0-email" size="30" maxlength="90" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-0-url" required="true" key="user.url"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][url]" id="authors-0-url" size="30" maxlength="90" /></div></td>
					</tr>
					{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
						<tr valign="top">
							<td width="20%">{fieldLabel name="authors-0-competingInterests" key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}</td>
							<td width="80%" class="value"><div class="form-group"><textarea name="authors[0][competingInterests][{$formLocale|escape}]" class="form-control" id="authors-0-competingInterests" rows="5" cols="40"></textarea></div></td>
						</tr>
					{/if}
					<tr valign="top">
						<td width="20%">{fieldLabel name="authors-0-biography" key="user.biography"}<br />{translate key="user.biography.description"}</td>
						<td width="80%" class="value"><div class="form-group"><textarea name="authors[0][biography][{$formLocale|escape}]" class="form-control" id="authors-0-biography" rows="5" cols="40"></textarea></div></td>
					</tr>
				</table>
			</div>
		{/foreach}

		<p><input type="submit" class="btn btn-success" name="addAuthor" value="{translate key="author.submit.addAuthor"}" /></p>
	</div>
	
	<div class="separator"></div>

	<div id="titleAndAbstract" class="col-md-12 mag-innert-left">
		<h3>{translate key="submission.titleAndAbstract"}</h3>
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="title" required="true" key="article.title"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="60" maxlength="255" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{if $section->getAbstractsNotRequired()==0}{fieldLabel name="abstract" key="article.abstract" required="true"}{else}{fieldLabel name="abstract" key="article.abstract"}{/if}</td>
					<td width="80%" class="value"><div class="form-group"><textarea name="abstract[{$formLocale|escape}]" id="abstract" class="form-control" rows="15" cols="60">{$abstract[$formLocale]|escape}</textarea></div></td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	{if $section->getMetaIndexed()==1}
		<div id="indexing" class="col-md-12 mag-innert-left">
			<h3>{translate key="submission.indexing"}</h3>
			{if $currentJournal->getSetting('metaDiscipline') || $currentJournal->getSetting('metaSubjectClass') || $currentJournal->getSetting('metaSubject') || $currentJournal->getSetting('metaCoverage') || $currentJournal->getSetting('metaType')}<p class="help-block">{translate key="author.submit.submissionIndexingDescription"}</p>{/if}
			
			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					{if $currentJournal->getSetting('metaDiscipline')}
						<tr valign="top">
							<td{if $currentJournal->getLocalizedSetting('metaDisciplineExamples') != ''} rowspan="2"{/if} width="20%">{fieldLabel name="discipline" key="article.discipline"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="discipline[{$formLocale|escape}]" id="discipline" value="{$discipline[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						{if $currentJournal->getLocalizedSetting('metaDisciplineExamples')}
							<tr valign="top">
								<td><p class="help-block">{$currentJournal->getLocalizedSetting('metaDisciplineExamples')|escape}</p></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					{/if}

					{if $currentJournal->getSetting('metaSubjectClass')}
						<tr valign="top">
							<td rowspan="2" width="20%">{fieldLabel name="subjectClass" key="article.subjectClassification"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="subjectClass[{$formLocale|escape}]" id="subjectClass" value="{$subjectClass[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						<tr valign="top">
							<td width="20%"><a href="{$currentJournal->getLocalizedSetting('metaSubjectClassUrl')|escape}" target="_blank">{$currentJournal->getLocalizedSetting('metaSubjectClassTitle')|escape}</a></td>
						</tr>
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					{/if}

					{if $currentJournal->getSetting('metaSubject')}
						<tr valign="top">
							<td{if $currentJournal->getLocalizedSetting('metaSubjectExamples') != ''} rowspan="2"{/if} width="20%">{fieldLabel name="subject" key="article.subject"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="subject[{$formLocale|escape}]" id="subject" value="{$subject[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						{if $currentJournal->getLocalizedSetting('metaSubjectExamples') != ''}
							<tr valign="top">
								<td><p class="help-block">{$currentJournal->getLocalizedSetting('metaSubjectExamples')|escape}</p></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					{/if}

					{if $currentJournal->getSetting('metaCoverage')}
						<tr valign="top">
							<td{if $currentJournal->getLocalizedSetting('metaCoverageGeoExamples') != ''} rowspan="2"{/if} width="20%">{fieldLabel name="coverageGeo" key="article.coverageGeo"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="coverageGeo[{$formLocale|escape}]" id="coverageGeo" value="{$coverageGeo[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						{if $currentJournal->getLocalizedSetting('metaCoverageGeoExamples')}
							<tr valign="top">
								<td><p class="help-block">{$currentJournal->getLocalizedSetting('metaCoverageGeoExamples')|escape}</p></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr valign="top">
							<td{if $currentJournal->getLocalizedSetting('metaCoverageChronExamples') != ''} rowspan="2"{/if} width="20%">{fieldLabel name="coverageChron" key="article.coverageChron"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="coverageChron[{$formLocale|escape}]" id="coverageChron" value="{$coverageChron[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						{if $currentJournal->getLocalizedSetting('metaCoverageChronExamples') != ''}
							<tr valign="top">
								<td><p class="help-block">{$currentJournal->getLocalizedSetting('metaCoverageChronExamples')|escape}</p></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr valign="top">
							<td{if $currentJournal->getLocalizedSetting('metaCoverageResearchSampleExamples') != ''} rowspan="2"{/if} width="20%">{fieldLabel name="coverageSample" key="article.coverageSample"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="coverageSample[{$formLocale|escape}]" id="coverageSample" value="{$coverageSample[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						{if $currentJournal->getLocalizedSetting('metaCoverageResearchSampleExamples') != ''}
							<tr valign="top">
								<td><p class="help-block">{$currentJournal->getLocalizedSetting('metaCoverageResearchSampleExamples')|escape}</p></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					{/if}

					{if $currentJournal->getSetting('metaType')}
						<tr valign="top">
							<td width="20%" {if $currentJournal->getLocalizedSetting('metaTypeExamples') != ''}rowspan="2" {/if}>{fieldLabel name="type" key="article.type"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="type[{$formLocale|escape}]" id="type" value="{$type[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>

						{if $currentJournal->getLocalizedSetting('metaTypeExamples') != ''}
							<tr valign="top">
								<td><p class="help-block">{$currentJournal->getLocalizedSetting('metaTypeExamples')|escape}</p></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					{/if}

					<tr valign="top">
						<td rowspan="2" width="20%">{fieldLabel name="language" key="article.language"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="language" id="language" value="{$language|escape}" size="5" maxlength="10" /></div></td>
					</tr>
					<tr valign="top">
						<td><p class="help-block">{translate key="author.submit.languageInstructions"}</p></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="separator"></div>
	{/if}

	<div id="submissionSupportingAgencies" class="col-md-12 mag-innert-left">
		<h3>{translate key="author.submit.submissionSupportingAgencies"}</h3>
		<p class="help-block">{translate key="author.submit.submissionSupportingAgenciesDescription"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped>
				<tr valign="top">
					<td width="20%">{fieldLabel name="sponsor" key="submission.agencies"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="sponsor[{$formLocale|escape}]" id="sponsor" value="{$sponsor[$formLocale]|escape}" size="60" maxlength="255" /></div></td>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="separator"></div>

	{call_hook name="Templates::Author::Submit::AdditionalMetadata"}

	{if $currentJournal->getSetting('metaCitations')}
		<div id="metaCitations" class="col-md-12 mag-innert-left">
			<h3>{translate key="submission.citations"}</h3>
			<p class="help-block">{translate key="author.submit.submissionCitations"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{fieldLabel name="citations" key="submission.citations"}</td>
						<td width="80%" class="value"><div class="form-group"><textarea name="citations" id="citations" class="form-control" rows="15" cols="60">{$citations|escape}</textarea></div></td>
					</tr>
				</table>
			</div>

			<div class="separator"></div>

		</div>
	{/if}

	<p><input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{if $scrollToAuthor}
	<script type="text/javascript">
	{literal}
		var authors = document.getElementById('authors');
		authors.scrollIntoView(false);
	{/literal}
	</script>
{/if}

{include file="common/footer.tpl"}