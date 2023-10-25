import classNames from '@ember-eui/core/helpers/class-names';
import argOrDefault from '@ember-eui/core/helpers/arg-or-default';

import { eq } from 'ember-truth-helpers';
import EuiStepNumber from '@ember-eui/core/components/eui-step-number';
import EuiTitle from '@ember-eui/core/components/eui-title';

<template>
  <div
    class={{classNames
      "euiStep"
      (if (eq @titleSize "xs") "euiStep--small")
      (if (eq @status "disabled") "euiStep-isDisabled")
    }}
    ...attributes
  >
    <div class="euiStep__titleWrapper">
      <EuiStepNumber
        class={{classNames
          "euiStep__circle"
          (if (eq @titleSize "xs") "euiStepNumber--small")
        }}
        @number={{@step}}
        @status={{@status}}
        @titleSize={{argOrDefault @titleSize "s"}}
        @isHollow={{eq @status "incomplete"}}
      />
      <EuiTitle
        @size={{@titleSize}}
        @tagName={{argOrDefault @headingElement "p"}}
        class="euiStep__title"
      >
        {{@title}}
      </EuiTitle>
    </div>
    <div class="euiStep__content">
      {{yield}}
    </div>
  </div>
</template>
