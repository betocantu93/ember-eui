---
title: Password field
---

<EuiPageHeader>
  <EuiPageHeaderSection>
    <EuiTitle @size="l">
      <h1>
        Password field
      </h1>
    </EuiTitle>
  </EuiPageHeaderSection>
</EuiPageHeader>

<EuiSpacer />

<EuiText>
  <p>
    Use a <strong>EuiFieldPassword</strong> to allow users to enter a password.
    By default, it renders a basic HTML <EuiCode @language="html">{{'<input type="password">'}}</EuiCode> where the content is obfuscated.
    When users type in the field the characters are presented as asterisks.
  </p>
  <p>
    You can change this default behavior by passing <EuiCode>{{'@type="dual"'}}</EuiCode> so that users can toggle between showing and obfuscating the content.
    This option makes the experience more user-friendly and accessible.
  </p>
</EuiText>