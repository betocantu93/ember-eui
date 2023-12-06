import ValidatedFormFieldBase from './field-base';
import type { FieldBaseSignature } from './field-base';
import { argOrDefault } from '@ember-eui/core/helpers';
import { on } from '@ember/modifier';
import uniqueId from 'ember-unique-id-helper-polyfill/helpers/unique-id';
import didInsert from '@ember/render-modifiers/modifiers/did-insert';
import didUpdate from '@ember/render-modifiers/modifiers/did-update';
import { EuiFormRow, EuiRange } from '@ember-eui/core/components';
import type { EuiFormRowSignature } from '@ember-eui/core/components/eui-form-row';
import type { EuiRangeSignature } from '@ember-eui/core/components/eui-range';
import { fn } from '@ember/helper';
import { not } from 'ember-truth-helpers';

export interface FieldRangeSliderSignature {
  Element: EuiRangeSignature['Element'];
  Args: FieldBaseSignature['Args'] &
    EuiFormRowSignature['Args'] &
    EuiRangeSignature['Args'] & {
      rowClasses?: string;
      fieldClasses?: string;
      formId?: string;
      ariaLabel?: string;
      autofocus?: boolean;
      onChange?: (state: boolean, e: MouseEvent) => void;
    };
  Blocks: {
    label: [];
    prepend: [...EuiRangeSignature['Blocks']['prepend']];
    min: [...EuiRangeSignature['Blocks']['min']];
    valuePrepend: [...EuiRangeSignature['Blocks']['valuePrepend']];
    value: [...EuiRangeSignature['Blocks']['value']];
    valueAppend: [...EuiRangeSignature['Blocks']['valueAppend']];
    append: [...EuiRangeSignature['Blocks']['append']];
    max: [...EuiRangeSignature['Blocks']['max']];
  };
}

export default class ValidatedFormFieldRangeSlider extends ValidatedFormFieldBase<FieldRangeSliderSignature> {
  <template>
    {{#let (argOrDefault @id (uniqueId)) as |theId|}}
      <EuiFormRow
        class={{@rowClasses}}
        @extra={{this.rowExtra}}
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
          <EuiRange
            class={{@fieldClasses}}
            form={{@formId}}
            @compressed={{@compressed}}
            @readOnly={{@readOnly}}
            @fullWidth={{@fullWidth}}
            @id={{theId}}
            @levels={{@levels}}
            @step={{@step}}
            @showInput={{@showInput}}
            @showLabels={{@showLabels}}
            @showRange={{@showRange}}
            @showTicks={{@showTicks}}
            @showValue={{@showValue}}
            @disabled={{@disabled}}
            @ticks={{@ticks}}
            @tickInterval={{@tickInterval}}
            @valuePrepend={{@valuePrepend}}
            @valueAppend={{@valueAppend}}
            @onChange={{this.handleChange}}
            @value={{@value}}
            @max={{@max}}
            @isLoading={{@isLoading}}
            @min={{@min}}
            @isInvalid={{this.isInvalidAndTouched}}
            @isPrependProvided={{has-block "prepend"}}
            @isAppendProvided={{has-block "append"}}
            @isFakeMinBlock={{not (has-block "min")}}
            @isFakeMaxBlock={{not (has-block "max")}}
            @isFakeValueBlock={{not (has-block "value")}}
            @isFakeValuePrependBlock={{not (has-block "valuePrepend")}}
            @isFakeValueAppendBlock={{not (has-block "valueAppend")}}
            aria-label={{@ariaLabel}}
            autofocus={{@autofocus}}
            ...attributes
            {{on "blur" (fn this.setIsTouched true)}}
          >
            <:prepend as |classes|>
              {{yield classes to="prepend"}}
            </:prepend>
            <:min as |min|>
              {{yield min to="min"}}
            </:min>
            <:valuePrepend>
              {{yield to="valuePrepend"}}
            </:valuePrepend>
            <:value>
              {{yield to="value"}}
            </:value>
            <:valueAppend>
              {{yield to="valueAppend"}}
            </:valueAppend>
            <:max as |max|>
              {{yield max to="max"}}
            </:max>
            <:append as |classes|>
              {{yield classes to="append"}}
            </:append>
          </EuiRange>
        </:field>
      </EuiFormRow>
    {{/let}}
  </template>
}
