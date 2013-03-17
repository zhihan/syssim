function test_suite = testDemos()
initTestSuite;
end

function test_galton()
d = pwd;
cd('galton');
evalin('base', 'demo_galton');
evalin('base', 'clear all');
evalin('base', 'close all');
cd(d);
end

function test_galton_sl()
d = pwd;
cd('galton');
evalin('base', 'demo_galton_sl');
evalin('base', 'clear all');
evalin('base', 'close all');
cd(d);
end

function test_fta()
d = pwd;
cd('fta');
evalin('base', 'demo_fta');
evalin('base', 'clear all');
evalin('base', 'close all');
cd(d);
end

function test_autotrans()
d = pwd;
cd('autotrans');
evalin('base', 'demo_autotrans');
evalin('base', 'clear all');
evalin('base', 'close all');
cd(d);
end
