import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import didInsert from '@ember/render-modifiers/modifiers/did-insert';

import noop from 'ember-composable-helpers/helpers/noop';
import { and, eq, notEq } from 'ember-truth-helpers';

import classNames from '../helpers/class-names';
import uniqueId from '../helpers/unique-id';
import EuiButton from './eui-button';
import EuiInnerText from './eui-inner-text';

<template>
  {{#let
    (if @isDisabled "button" @element)
    (uniqueId)
    (classNames
      (if @isSelected "euiButtonGroupButton-isSelected")
      (if @isIconOnly "euiButtonGroupButton-isIconOnly")
    )
    as |element newId classes|
  }}
    {{#let (notEq @element "label") as |isNotLabel|}}
      <EuiInnerText as |setInnerTextRef innerText|>
        <EuiButton
          @baseClassName="euiButtonGroupButton"
          class={{classes}}
          @element={{element}}
          @fill={{and (notEq @size "compressed") @isSelected}}
          @isDisabled={{@isDisabled}}
          @size={{if (eq @size "compressed") "s" @size}}
          @color={{@color}}
          @contentClasses={{@contentClasses}}
          @iconSide={{@iconSide}}
          @iconType={{@iconType}}
          @iconSize={{@iconSize}}
          @iconClasses={{@iconClasses}}
          @isLoading={{@isLoading}}
          @textClasses={{classNames
            @textClasses
            (if
              @isIconOnly
              "euiScreenReaderOnly"
              "euiButtonGroupButton__textShift"
            )
          }}
          @isSelected={{if isNotLabel @isSelected}}
          type={{if isNotLabel @type}}
          for={{if (eq element "label") newId}}
          id={{if isNotLabel newId}}
          title={{innerText}}
          {{on "click" (if isNotLabel (fn @onChange @id) (noop))}}
          {{didInsert setInnerTextRef}}
          ...attributes
        >
          {{#if (eq element "label")}}
            <input
              id={{newId}}
              class="euiScreenReaderOnly"
              name={{@name}}
              checked={{@isSelected}}
              disabled={{@isDisabled}}
              value={{@value}}
              type="radio"
              {{on "change" (fn @onChange @id @value)}}
            />
          {{/if}}
          {{@label}}
        </EuiButton>
      </EuiInnerText>
    {{/let}}
  {{/let}}
</template>
