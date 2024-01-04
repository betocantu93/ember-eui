import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import didInsert from '@ember/render-modifiers/modifiers/did-insert';
import didUpdate from '@ember/render-modifiers/modifiers/did-update';
import { EuiFormRow, EuiTextArea } from '@ember-eui/core/components';
import { argOrDefault } from '@ember-eui/core/helpers';

import { not } from 'ember-truth-helpers';
import uniqueId from 'ember-unique-id-helper-polyfill/helpers/unique-id';

import ValidatedFormFieldBase from './field-base.gts';

import type { FieldBaseSignature } from './field-base.gts';
import type { EuiFormRowSignature } from '@ember-eui/core/components/eui-form-row';
import type { EuiTextAreaSignature } from '@ember-eui/core/components/eui-text-area';
import type { ComponentLike } from '@glint/template';

export interface FieldTextAreaSignature extends FieldBaseSignature {
  Element: EuiTextAreaSignature['Element'];
  Args: FieldBaseSignature['Args'] &
    EuiFormRowSignature['Args'] &
    EuiTextAreaSignature['Args'] & {
      formId?: string;
      ariaLabel?: string;
      rows?: number;
      resize?: 'vertical' | 'horizontal' | 'both' | 'none';
      rowClasses?: string;
      fieldClasses?: string;
      labelAppend?: ComponentLike;
      prepend?: ComponentLike;
      append?: ComponentLike;
      placeholder?: string;
      autofocus?: boolean;
      inputRef?: (element: HTMLTextAreaElement) => void;
    };
  Blocks: {
    label: [];
    default: [...EuiTextAreaSignature['Blocks']['default']];
  };
}

export default class ValidatedFormFieldTextArea extends ValidatedFormFieldBase<FieldTextAreaSignature> {
  <template>
    {{#let (argOrDefault @id (uniqueId)) as |theId|}}
      <EuiFormRow
        class={{this.rowClasses}}
        @labelType={{@labelType}}
        @display={{@display}}
        @hasEmptyLabelSpace={{@hasEmptyLabelSpace}}
        @fullWidth={{@fullWidth}}
        @hasChildLabel={{@hasChildLabel}}
        @label={{this.label}}
        @labelAppend={{@labelAppend}}
        @id={{theId}}
        @isInvalid={{this.isInvalidAndTouched}}
        @error={{this.validationErrorMessages}}
        @helpText={{@helpText}}
        @errorClasses={{@errorClasses}}
        @isFakeLabelBlock={{not (has-block "label")}}
        {{didInsert this.setValidationMessages}}
        {{didUpdate this.didUpdateValue @validations}}
        {{didUpdate this.didUpdateValue @value}}
      >
        <:label>
          {{yield to="label"}}
        </:label>
        <:field>
          <EuiTextArea
            class={{@fieldClasses}}
            form={{@formId}}
            aria-label={{@ariaLabel}}
            @value={{@value}}
            @isInvalid={{this.isInvalidAndTouched}}
            @fullWidth={{@fullWidth}}
            @compressed={{@compressed}}
            @resize={{@resize}}
            @disabled={{@disabled}}
            @inputRef={{@inputRef}}
            @id={{theId}}
            @rows={{@rows}}
            autofocus={{@autofocus}}
            placeholder={{@placeholder}}
            ...attributes
            {{on "blur" (fn this.setIsTouched true)}}
            {{on "input" this.handleChange}}
          >
            {{yield}}
          </EuiTextArea>
        </:field>
      </EuiFormRow>
    {{/let}}
  </template>
}
