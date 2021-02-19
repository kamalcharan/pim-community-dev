import React from 'react';
import {Field, TextInput} from 'akeneo-design-system';
import {useTranslate} from '@akeneo-pim-community/legacy-bridge';
import {LocaleCode} from '@akeneo-pim-community/shared';
import {Descriptions} from '../../models';

type AttributeDescriptionsProps = {
  defaultValue: Descriptions;
  onChange: (defaultValue: {[key: string]: string}) => void;
};

const AttributeDescriptions = ({defaultValue, onChange}: AttributeDescriptionsProps) => {
  const translate = useTranslate();
  const [descriptions, setDescriptions] = React.useState<Descriptions>(defaultValue);

  const onDescriptionChange = (localeCode: LocaleCode, description: string) => {
    const newDescriptions = {...descriptions, localeCode: description};
    setDescriptions(newDescriptions);
    onChange(newDescriptions);
  };

  return (
    <Field label={translate('todo descriptions')}>
      {/*TODO: use a textarea */}
      <TextInput
        name={'descriptions'}
        type={'text'}
        onChange={(description: string) => {
          onDescriptionChange('todo', description);
        }}
      />
    </Field>
  );
};

export {AttributeDescriptions};
