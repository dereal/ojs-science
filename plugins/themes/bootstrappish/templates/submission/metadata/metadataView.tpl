{**
 * metadata_view.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * View (but not edit) metadata of an article. Used by MetadataForm.
 *
 *}
{strip}
{assign var="pageTitle" value="submission.viewMetadata"}
{include file="common/header.tpl"}
{/strip}

{if $canViewAuthors}
	<div id="authors" class="col-md-12 mag-innert-left">
		<h3>{translate key="article.authors"}</h3>

		<div class="table-responsive">	
			<table width="100%" class="table table-striped">
				{foreach name=authors from=$authors key=authorIndex item=author}
					<tr valign="top">
						<td width="20%">{translate key="user.name"}</td>
						<td width="80%" class="value">
							{assign var=emailString value=$author.firstName|concat:" ":$author.middleName:" ":$author.lastName:" <":$author.email:">"}
							{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl articleId=$articleId}
							{$author.firstName|escape} {$author.middleName|escape} {$author.lastName|escape} {icon name="mail" url=$url}
						</td>
					</tr>
					<tr valign="top">
						<td>{translate key="user.url"}</td>
						<td class="value">{$author.url|escape|default:"&mdash;"}</td>
					</tr>
					<tr valign="top">
						<td>{translate key="user.affiliation"}</td>
						<td class="value">{$author.affiliation.$formLocale|escape|nl2br|default:"&mdash;"}</td>
					</tr>
					<tr valign="top">
						<td>{translate key="common.country"}</td>
						<td class="value">{$author.countryLocalized|escape|default:"&mdash;"}</td>
					</tr>
					{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
						<tr valign="top">
							<td>
								{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}
								{translate key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}
							</td>
							<td class="value">{$author.competingInterests.$formLocale|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
						</tr>
					{/if}
					<tr valign="top">
						<td>{translate key="user.biography"}</td>
						<td class="value">{$author.biography.$formLocale|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
					</tr>
					{if !$smarty.foreach.authors.last}
						<tr>
							<td colspan="2" class="separator">&nbsp;</td>
						</tr>
					{/if}
				{/foreach}
			</table>
		</div>
	</div>

	<div class="separator"></div>
{/if}

<div id="titleAndAbstract" class="col-md-12 mag-innert-left">
	<h3>{translate key="submission.titleAndAbstract"}</h3>
	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr valign="top">
				<td width="20%">{translate key="article.title"}</td>
				<td width="80%" class="value">{$title[$formLocale]|strip_unsafe_html|default:"&mdash;"}</td>
			</tr>

			<tr>
				<td colspan="2" class="separator">&nbsp;</td>
			</tr>
			<tr valign="top">
				<td>{translate key="article.abstract"}</td>
				<td class="value">{$abstract[$formLocale]|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
			</tr>
		</table>
	</div>
</div>

<div class="separator"></div>

<div id="cover" class="col-md-12 mag-innert-left">
	<h3>{translate key="editor.article.cover"}</h3>
	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr valign="top">
				<td width="20%">{fieldLabel name="coverPage" key="editor.article.coverPage"}</td>
				<td width="80%" class="value">{if $fileName[$formLocale]}<a href="javascript:openWindow('{$publicFilesDir}/{$fileName[$formLocale]|escape:"url"}');" class="file">{$originalFileName[$formLocale]}</a>{else}&mdash;{/if}</td>
			</tr>

			<tr>
				<td colspan="2" class="separator">&nbsp;</td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="coverPageAltText" key="common.altText"}</td>
				<td class="value">{$coverPageAltText[$formLocale]|escape}</td>
			</tr>
		</table>
	</div>
</div>

<div class="separator"></div>

<div id="indexing" class="col-md-12 mag-innert-left">
	<h3>{translate key="submission.indexing"}</h3>	
	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			{if $currentJournal->getSetting('metaDiscipline')}
				<tr valign="top">
					<td width="20%">{translate key="article.discipline"}</td>
					<td width="80%" class="value">{$discipline[$formLocale]|escape|default:"&mdash;"}</td>
				</tr>
				<tr>
					<td colspan="2" class="separator">&nbsp;</td>
				</tr>
			{/if}
			{if $currentJournal->getSetting('metaSubjectClass')}
				<tr valign="top">
					<td colspan="2"><a href="{$currentJournal->getLocalizedSetting('metaSubjectClassUrl')|escape}" target="_blank">{$currentJournal->getLocalizedSetting('metaSubjectClassTitle')|escape}</a></td>
				</tr>
				<tr valign="top">
					<td width="20%">{translate key="article.subjectClassification"}</td>
					<td width="80%" class="value">{$subjectClass[$formLocale]|escape|default:"&mdash;"}</td>
				</tr>
				<tr>
					<td colspan="2" class="separator">&nbsp;</td>
				</tr>
			{/if}
			{if $currentJournal->getSetting('metaSubject')}
				<tr valign="top">
					<td width="20%">{translate key="article.subject"}</td>
					<td width="80%" class="value">{$subject[$formLocale]|escape|default:"&mdash;"}</td>
				</tr>
				<tr>
					<td colspan="2" class="separator">&nbsp;</td>
				</tr>
			{/if}
			{if $currentJournal->getSetting('metaCoverage')}
				<tr valign="top">
					<td width="20%">{translate key="article.coverageGeo"}</td>
					<td width="80%" class="value">{$coverageGeo[$formLocale]|escape|default:"&mdash;"}</td>
				</tr>
				<tr>
					<td colspan="2" class="separator">&nbsp;</td>
				</tr>
				<tr valign="top">
					<td>{translate key="article.coverageChron"}</td>
					<td class="value">{$coverageChron[$formLocale]|escape|default:"&mdash;"}</td>
				</tr>
				<tr>
					<td colspan="2" class="separator">&nbsp;</td>
				</tr>
				<tr valign="top">
					<td>{translate key="article.coverageSample"}</td>
					<td class="value">{$coverageSample[$formLocale]|escape|default:"&mdash;"}</td>
				</tr>
				<tr>
					<td colspan="2" class="separator">&nbsp;</td>
				</tr>
			{/if}
			{if $currentJournal->getSetting('metaType')}
				<tr valign="top">
					<td width="20%">{translate key="article.type"}</td>
					<td width="80%" class="value">{$type[$formLocale]|escape|default:"&mdash;"}</td>
				</tr>
				<tr>
					<td colspan="2" class="separator">&nbsp;</td>
				</tr>
			{/if}
			<tr valign="top">
				<td width="20%">{translate key="article.language"}</td>
				<td width="80%" class="value">{$language|escape|default:"&mdash;"}</td>
			</tr>
		</table>
	</div>
</div>

<div class="separator"></div>

<div id="supportingAgencies" class="col-md-12 mag-innert-left">
	<h3>{translate key="submission.supportingAgencies"}</h3>	
	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr valign="top">
				<td width="20%">{translate key="submission.agencies"}</td>
				<td width="80%" class="value">{$sponsor[$formLocale]|escape|default:"&mdash;"}</td>
			</tr>
		</table>
	</div>
</div>

{include file="common/footer.tpl"}