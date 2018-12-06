import ReactOnRails from 'react-on-rails';

import UploadCsv from '../bundles/UploadCsv/components/UploadCsv';
import HelloWorld from '../bundles/HelloWorld/components/HelloWorld';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  UploadCsv, HelloWorld
});