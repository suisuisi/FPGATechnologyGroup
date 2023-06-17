function blkStruct = slblocks
%SLBLOCKS Defines the Simulink library block representation

blkStruct.Name    = ['Adaptive' sprintf('\n') 'Blockset'];
blkStruct.OpenFcn = 'adapt';
blkStruct.MaskInitialization = '';

% blkStruct.MaskDisplay = ['disp(''Adaptive\nBlockset'')'];

% Define the library list for the Simulink Library browser.
% Return the name of the library model and the name for it
%
% Browser(1).Library = 'adapt';
% Browser(1).Name    = 'Adaptive Blockset';

% blkStruct.Browser = Browser;

% End of slblocks.m
