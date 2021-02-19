import React from 'react';
import {ReactView} from '@akeneo-pim-community/legacy-bridge/src/bridge/react';

// const mediator = require('oro/mediator');

class AttributeProperties extends ReactView {
  reactElementToMount() {
    return <EditAttributePropertiesApp />;
  }
}

export = AttributeProperties;
