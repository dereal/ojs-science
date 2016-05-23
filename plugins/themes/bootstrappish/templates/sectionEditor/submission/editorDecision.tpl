{**
 * templates/sectionEditor/submission/editorDecision.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the editor decision table.
 *
 *}

<div id="editorDecision" class="col-md-12 mag-innert-left">
	<h3>{translate key="submission.editorDecision"}</h3>

	<div class="table-responsive">
		<table id="table1" width="100%" class="table table-striped">
			<tr valign="top">
				<td width="20%">{translate key="editor.article.selectDecision"}</td>
				<td width="80%" class="value">
					<form role="form" method="post" action="{url op="recordDecision"}">
						<input type="hidden" name="articleId" value="{$submission->getId()}" />
						<div class="form-group">
							<select name="decision" size="1" class="form-control"{if not $allowRecommendation} disabled="disabled"{/if}>
								{html_options_translate options=$editorDecisionOptions selected=$lastDecision}
							</select>
						</div>
						<input type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmDecision"}')" name="submit" value="{translate key="editor.article.recordDecision"}" {if not $allowRecommendation}disabled="disabled"{/if} class="btn btn-success" />
						{if not $allowRecommendation}&nbsp;&nbsp;{translate key="editor.article.cannotRecord"}{/if}
					</form>
				</td>
			</tr>
			<tr valign="top">
				<td>{translate key="editor.article.decision"}</td>
				<td class="value">
					{foreach from=$submission->getDecisions($round) item=editorDecision key=decisionKey}
						{if $decisionKey neq 0} | {/if}
						{assign var="decision" value=$editorDecision.decision}
						{translate key=$editorDecisionOptions.$decision}&nbsp;&nbsp;{if $editorDecision.dateDecided != 0}{$editorDecision.dateDecided|date_format:$dateFormatShort}{/if}
					{foreachelse}
						{translate key="common.none"}
					{/foreach}
				</td>
			</tr>
			<tr valign="top">
				<td>{translate key="submission.notifyAuthor"}</td>
				<td class="value">
					{url|assign:"notifyAuthorUrl" op="emailEditorDecisionComment" articleId=$submission->getId()}

					{if $decision == SUBMISSION_EDITOR_DECISION_DECLINE}
						{* The last decision was a decline; notify the user that sending this message will archive the submission. *}
						{translate|escape:"quotes"|assign:"confirmString" key="editor.submissionReview.emailWillArchive"}
						{icon name="mail" url=$notifyAuthorUrl onclick="return confirm('$confirmString')"}
					{else}
						{icon name="mail" url=$notifyAuthorUrl}
					{/if}

					&nbsp;&nbsp;&nbsp;&nbsp;
					{translate key="submission.editorAuthorRecord"}
					{if $submission->getMostRecentEditorDecisionComment()}
						{assign var="comment" value=$submission->getMostRecentEditorDecisionComment()}
						<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{$comment->getDatePosted()|date_format:$dateFormatShort}
					{else}
						<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
					{/if}
				</td>
			</tr>
		</table>
	</div>

	<form role="form" method="post" action="{url op="editorReview"}" enctype="multipart/form-data">
		<input type="hidden" name="articleId" value="{$submission->getId()}" />
		{assign var=authorFiles value=$submission->getAuthorFileRevisions($round)}
		{assign var=editorFiles value=$submission->getEditorFileRevisions($round)}

		{assign var="authorRevisionExists" value=false}
		{foreach from=$authorFiles item=authorFile}
			{assign var="authorRevisionExists" value=true}
		{/foreach}

		{assign var="editorRevisionExists" value=false}
		{foreach from=$editorFiles item=editorFile}
			{assign var="editorRevisionExists" value=true}
		{/foreach}
		{if $reviewFile}
			{assign var="reviewVersionExists" value=1}
		{/if}

		<div class="table-responsive">
			<table id="table2" class="table table-striped" width="100%">
				{if $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
					<tr>
						<td width="20%">&nbsp;</td>
						<td width="80%">
							{translate key="editor.article.resubmitFileForPeerReview"}
							<input type="submit" name="resubmit" {if !($editorRevisionExists or $authorRevisionExists or $reviewVersionExists)}disabled="disabled" {/if}value="{translate key="form.resubmit"}" class="btn btn-warning" />
						</td>
					</tr>
				{elseif $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT}
					<tr valign="top">
						<td width="20%">&nbsp;</td>
						<td width="80%">
							{if !($editorRevisionExists or $authorRevisionExists or $reviewVersionExists) or !$submission->getMostRecentEditorDecisionComment()}{assign var=copyeditingUnavailable value=1}{else}{assign var=copyeditingUnavailable value=0}{/if}
							<input type="submit" {if $copyeditingUnavailable}disabled="disabled" {/if}name="setCopyeditFile" value="{translate key="editor.submissionReview.sendToCopyediting"}" class="btn btn-success" />
							{if $copyeditingUnavailable}
								<br/>				
								<p class="help-block">{translate key="editor.submissionReview.cannotSendToCopyediting"}</p>
							{/if}
						</td>
					</tr>
				{/if}

				{if $reviewFile}
					<tr valign="top">
						<td width="20%">{translate key="submission.reviewVersion"}</td>
						<td width="50%" class="value">
							{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
								<div class="form-group"><input type="radio" name="editorDecisionFile" value="{$reviewFile->getFileId()},{$reviewFile->getRevision()}" /></div>
							{/if}
							<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;
							{$reviewFile->getDateModified()|date_format:$dateFormatShort}
							{if $copyeditFile && $copyeditFile->getSourceFileId() == $reviewFile->getFileId()}
								&nbsp;&nbsp;&nbsp;&nbsp;{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}
							{/if}
						</td>
					</tr>
				{/if}
				{assign var="firstItem" value=true}
				{foreach from=$authorFiles item=authorFile key=key}
					<tr valign="top">
						{if $firstItem}
							{assign var="firstItem" value=false}
							<td width="20%" rowspan="{$authorFiles|@count}">{translate key="submission.authorVersion"}</td>
						{/if}
						<td width="80%" class="value">
							{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}<input type="radio" name="editorDecisionFile" value="{$authorFile->getFileId()},{$authorFile->getRevision()}" /> {/if}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;
							{$authorFile->getDateModified()|date_format:$dateFormatShort}
							{if $copyeditFile && $copyeditFile->getSourceFileId() == $authorFile->getFileId()}
								&nbsp;&nbsp;&nbsp;&nbsp;{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}
							{/if}
						</td>
					</tr>
				{foreachelse}
					<tr valign="top">
						<td width="20%">{translate key="submission.authorVersion"}</td>
						<td width="80%" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
					</tr>
				{/foreach}
				{assign var="firstItem" value=true}
				{foreach from=$editorFiles item=editorFile key=key}
					<tr valign="top">
						{if $firstItem}
							{assign var="firstItem" value=false}
							<td width="20%" rowspan="{$editorFiles|@count}">{translate key="submission.editorVersion"}</td>
						{/if}
						<td width="80%" class="value">
							{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}<input type="radio" name="editorDecisionFile" value="{$editorFile->getFileId()},{$editorFile->getRevision()}" /> {/if}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="file">{$editorFile->getFileName()|escape}</a>&nbsp;&nbsp;
							{$editorFile->getDateModified()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
							{if $copyeditFile && $copyeditFile->getSourceFileId() == $editorFile->getFileId()}
								{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
							{/if}
							<a href="{url op="deleteArticleFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="action">{translate key="common.delete"}</a>
						</td>
					</tr>
				{foreachelse}
					<tr valign="top">
						<td width="20%">{translate key="submission.editorVersion"}</td>
						<td width="80%" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
					</tr>
				{/foreach}
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<div class="form-group"><input type="file" name="upload" class="form-control" /></div>
						<input type="submit" name="submit" value="{translate key="common.upload"}" class="btn btn-success" />
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>