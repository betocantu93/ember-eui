import argOrDefault from '@ember-eui/core/helpers/arg-or-default';
import classNames from '@ember-eui/core/helpers/class-names';
import { eq, or, not } from 'ember-truth-helpers';
import EuiIcon from '@ember-eui/core/components/eui-icon';

<template>
  <div class="euiCommentTimeline" ...attributes>
    <div class="euiCommentTimeline__content">
      <div
        class={{classNames
          (if
            (or @timelineIcon (not (has-block "timelineIcon")))
            "euiCommentTimeline__icon--default"
          )
          componentName="EuiCommentTimelineIcon"
          type=(argOrDefault @type "regular")
        }}
      >
        {{#if @timelineIcon}}
          <EuiIcon
            @size={{if (eq @type "update") "m" "l"}}
            @type={{@timelineIcon}}
          />
        {{else if (has-block "timelineIcon")}}
          {{yield to="timelineIcon"}}
        {{else}}
          <EuiIcon
            @type={{if (eq @type "update") "dot" "user"}}
            @size={{if (eq @type "update") "m" "l"}}
          />
        {{/if}}
      </div>
    </div>
  </div>
</template>
