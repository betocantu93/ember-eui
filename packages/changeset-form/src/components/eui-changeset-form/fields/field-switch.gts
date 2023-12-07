import Base from './base';
import type { BaseSignature } from './base';
import { EuiFormRow, EuiSwitch } from '@ember-eui/core/components';
import type { EuiFormRowSignature } from '@ember-eui/core/components/eui-form-row';
import type { EuiSwitchSignature } from '@ember-eui/core/components/eui-switch';
import { argOrDefault } from '@ember-eui/core/helpers';
import uniqueId from 'ember-unique-id-helper-polyfill/helpers/unique-id';
import { action } from '@ember/object';
import { not } from 'ember-truth-helpers';

export interface EuiChangesetFormFieldSwitchSignature {
  Element: EuiSwitchSignature['Element'];
  Args: BaseSignature['Args'] &
    EuiFormRowSignature['Args'] &
    EuiSwitchSignature['Args'] & {
      onChange?: (value: boolean, event: Event) => void;
      fieldClasses?: string;
      ariaLabel?: string;
      autofocus?: boolean;
      switchLabel?: string;
      placeholder?: string;
    };

  Blocks: {
    label?: EuiSwitchSignature['Blocks']['label'];
  };
}

export default class EuiChangesetFormFieldSwitch extends Base<EuiChangesetFormFieldSwitchSignature> {
  form: HTMLFormElement | null = null;

  @action
  handleChange(e: Event) {
    e.preventDefault();
    const checked = (e.target as HTMLInputElement).checked;
    this.args.changeset.set(this.args.fieldName, checked);
    this.validate();
    this.args.onChange?.(checked, e);
  }

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
        @label={{@label}}
        @labelAppend={{@labelAppend}}
        @id={{theId}}
        @isInvalid={{this.isInvalid}}
        @error={{this.errors}}
        @helpText={{@helpText}}
        @errorClasses={{@errorClasses}}
      >
        <EuiSwitch
          class={{@fieldClasses}}
          form={{@formId}}
          aria-label={{@ariaLabel}}
          @id={{theId}}
          @showLabel={{@showLabel}}
          @label={{@switchLabel}}
          @checked={{this.value}}
          @onChange={{this.handleChange}}
          @isFakeLabelBlock={{not (has-block "label")}}
          @disabled={{@disabled}}
          @compressed={{@compressed}}
          @type={{@type}}
          ...attributes
        >
          <:label>
            {{yield to="label"}}
          </:label>
        </EuiSwitch>
      </EuiFormRow>
    {{/let}}
  </template>
}
