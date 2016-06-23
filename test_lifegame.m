classdef test_lifegame < matlab.unittest.TestCase
    properties(TestParameter)
        prev_map = struct('lonely',...
                          [0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 1 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0],...
                          'pair',...
                          [0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 1 1 0;
                           0 0 0 0 0;
                           0 0 0 0 0],...
                          'threesome',...
                          [0 0 0 0 0;
                           0 1 0 0 0;
                           0 0 1 0 0;
                           0 0 0 1 0;
                           0 0 0 0 0],...
                          'gangOfFour',...
                          [0 0 0 0 0;
                           0 0 1 0 0;
                           0 0 1 1 0;
                           0 1 0 0 0;
                           0 0 0 0 0],...
                          'crowded',...
                          [0 0 0 0 0;
                           0 1 1 0 0;
                           0 1 1 1 0;
                           0 0 0 0 0;
                           0 0 0 0 0]...
                           );
        next_map = struct('one',...
                          [0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0],...
                          'pair',...
                          [0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0],...
                          'threesome',...
                          [0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 1 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0],...
                          'gangOfFour',...
                          [0 0 0 0 0;
                           0 0 1 1 0;
                           0 1 1 1 0;
                           0 0 1 0 0;
                           0 0 0 0 0],...
                          'crowded',...
                          [0 0 0 0 0;
                           0 1 0 1 0;
                           0 1 0 1 0;
                           0 0 1 0 0;
                           0 0 0 0 0]...
                           );
        prev_map_loop = struct(...
                          'R_L',...
                          [0 0 0 0 0;
                           1 0 0 0 0;
                           1 0 0 0 0;
                           1 0 0 0 0;
                           0 0 0 0 0],...
                          'U_D',...
                          [0 0 1 0 0;
                           0 0 1 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 1 0 0],...
                          'UL_DR',...
                          [1 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 1 0;
                           0 0 0 0 1],...
                          'UR_DL',...
                          [0 0 0 0 1;
                           0 0 0 1 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           1 0 0 0 0]...
                           );
        next_map_loop = struct(...
                          'R_L',...
                          [0 0 0 0 0;
                           0 0 0 0 0;
                           1 1 0 0 1;
                           0 0 0 0 0;
                           0 0 0 0 0],...
                          'U_D',...
                          [0 1 1 1 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0],...
                          'UL_DR',...
                          [0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 1],...
                          'UR_DL',...
                          [0 0 0 0 1;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0;
                           0 0 0 0 0]...
                           );
    end
    methods (Test)
        function testCreate(testCase)
            testee = lifegame([3,4]);
            testCase.verifyEqual(size(testee.Map), [3,4]);
            testCase.verifyEqual(isempty(setdiff(testee.Map,[0,1])), true);
        end
    end
    methods (Test, ParameterCombination='sequential')
        function testUpdate(testCase, prev_map, next_map)
            testee = lifegame([1,1]);
            testee.Map = prev_map;
            testee.update();
            testCase.verifyEqual(testee.Map, next_map);
        end
        function testUpdate_LoopBoundary(testCase, prev_map_loop, next_map_loop)
            testee = lifegame([1,1], 'loop');
            testee.Map = prev_map_loop;
            testee.update();
            testCase.verifyEqual(testee.Map, next_map_loop);
        end
    end
end