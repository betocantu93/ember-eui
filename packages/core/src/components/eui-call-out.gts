import argOrDefault from '@ember-eui/core/helpers/arg-or-default';
import classNames from '@ember-eui/core/helpers/class-names';
import { eq, or } from 'ember-truth-helpers';
import TextBlock from '@ember-eui/core/components/text-block';
import EuiText from '@ember-eui/core/components/eui-text';
import EuiIcon from '@ember-eui/core/components/eui-icon';

<template>
  <div
    class={{classNames
      componentName="EuiCallOut"
      size=(argOrDefault @size "m")
      color=(argOrDefault @color "primary")
    }}
    ...attributes
  >
    {{#if (or @title (has-block "title"))}}
      <div class="euiCallOutHeader">
        {{#if @iconType}}
          <EuiIcon
            @iconClasses="euiCallOutHeader__icon"
            @type={{@iconType}}
            @size="m"
            aria-hidden="true"
            @color="inherit"
          />
        {{/if}}
        {{#if @heading}}
          <TextBlock @tagName={{@heading}} class="euiCallOutHeader__title">
            {{#if (has-block "title")}}
              {{yield to="title"}}
            {{else}}
              {{@title}}
            {{/if}}
          </TextBlock>
        {{else}}
          <span class="euiCallOutHeader__title">
            {{#if (has-block "title")}}
              {{yield to="title"}}
            {{else}}
              {{@title}}
            {{/if}}
          </span>
        {{/if}}
      </div>
    {{/if}}
    {{#if (has-block "body")}}
      <EuiText @size={{if (eq @size "s") "xs" "s"}}>
        {{yield to="body"}}
      </EuiText>
    {{/if}}
  </div>
</template>
