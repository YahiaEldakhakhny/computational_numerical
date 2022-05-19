classdef TableDataAppExample_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        LinearregressionUIFigure      matlab.ui.Figure
        b                             matlab.ui.control.NumericEditField
        bLabel                        matlab.ui.control.Label
        a                             matlab.ui.control.NumericEditField
        aLabel                        matlab.ui.control.Label
        ClearTableButton              matlab.ui.control.Button
        ModelDropDown                 matlab.ui.control.DropDown
        ModelDropDownLabel            matlab.ui.control.Label
        LoadFromExelSheetButton       matlab.ui.control.Button
        ExcelSheetPathEditField       matlab.ui.control.EditField
        ExcelSheetPathEditFieldLabel  matlab.ui.control.Label
        s_t                           matlab.ui.control.NumericEditField
        s_tEditFieldLabel             matlab.ui.control.Label
        s_r                           matlab.ui.control.NumericEditField
        s_rEditFieldLabel             matlab.ui.control.Label
        r_2                           matlab.ui.control.NumericEditField
        r2EditFieldLabel              matlab.ui.control.Label
        r                             matlab.ui.control.NumericEditField
        rEditFieldLabel               matlab.ui.control.Label
        a1                            matlab.ui.control.NumericEditField
        a1EditFieldLabel              matlab.ui.control.Label
        a0                            matlab.ui.control.NumericEditField
        a0EditFieldLabel              matlab.ui.control.Label
        AddButton                     matlab.ui.control.Button
        YEditField                    matlab.ui.control.NumericEditField
        YEditFieldLabel               matlab.ui.control.Label
        XEditField                    matlab.ui.control.NumericEditField
        XEditFieldLabel               matlab.ui.control.Label
        UITable                       matlab.ui.control.Table
        UIAxes                        matlab.ui.control.UIAxes
    end


    methods (Access = private)
        
        
        
        function updateplot(app)
            % Get Table UI component data
            t = app.UITable.DisplayData;            
            model = app.ModelDropDown.Value;
            
            
            % Plot modified data 
            x1 =t.x;
            y1 = t.y;
            scatter(app.UIAxes,x1,y1);
            hold(app.UIAxes,"on");
            
            
            if size(x1)<2
               time=y1;

            else
               time=linspace(min(x1),max(x1),10000);

            end
            
            
           switch model
               
            case 'Power'
                 y1=log10(y1);
                 x1=log10(x1);
                 
            case 'Exponential'
                y1=log(y1);      
                
            case 'Growth_Rate'
                y1=1./y1;
                x1=1./x1;       
                
               otherwise
           end
         
            
            [a0v,a1v,stv]=linear_reg(app,x1,y1);
          
            srv = sum( (y1 -a0v -a1v.*x1) .^2 );
            
            y_num =a1v.*x1+a0v;
            

            switch model
               
            case 'Power'
                 a=10^a0v;
                 b=a1v;
                 y_fun=a.*(time.^b);
                 plot(app.UIAxes,time,y_fun,'Color','green');
                 hold(app.UIAxes,"off");
             
            case 'Exponential'
                a=exp(a0v);
                b=a1v;
                y_fun=a.*exp(b.*time);
                plot(app.UIAxes,time,y_fun,'Color','green');
                hold(app.UIAxes,"off");

              
            case 'Growth_Rate'       
                a=1/a0v;
                b=a1v/a0v;
                y_fun=(a.*time)./(b+time);
                plot(app.UIAxes,time,y_fun,'Color','green');
                hold(app.UIAxes,"off");
                otherwise
               % y_fun=a1v.*time+a0v;
                plot(app.UIAxes,x1,y_num,'Color','red');
                hold(app.UIAxes,"off");
                a=a1v;
                b=a0v;

           end
            
           
           
            if stv~=0
            r2v = (stv - srv)/stv;
            else
                r2v=0;
            end
      
            app.a0.Value=a0v;
            app.a1.Value=a1v;
            app.s_t.Value=stv;
            app.s_r.Value=srv;
            app.r_2.Value=r2v;
            app.r.Value=sqrt(r2v);
            app.b.Value=b;
            app.a.Value=a;
            


            
        end
        
        
       
            
        function [a0, a1,st] = linear_reg(~,x,y)
                  % VARIABLE DECLARATION AND CALCULATION
                  n = length(x);
                  sum_x = sum(x);
                  sum_y = sum(y);
                  sum_x2 = sum(x.^2);
                  sum_xy = sum(x.*y);
                  A = [n sum_x sum_y; sum_x sum_x2 sum_xy];
                  % SOLVE THE LINEAR SYSTEM OF EQUATIONS (GAUSS JORDAN ELIMINATION)
                  solution = rref(A);
                  a0 = solution(1,3);
                  a1 = solution(2,3);
                  st = sum((y-(sum_y/n)).^2);
                  
            end
            
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            t = table([],[],'VariableNames',{'x','y'}) ;
            vars = {'x','y'};
            
            % Select a subset of the table array
            t = t(1:end,vars);
         %  t=table(0, 0);
            % Add data to the Table UI Component
            app.UITable.Data = t;
            
            % Plot the original data
            x1 = app.UITable.Data.x;
            y1 = app.UITable.Data.y;
            
            % Plot the data
            updateplot(app);

        end

        % Display data changed function: UITable
        function UITableDisplayDataChanged(app, event)
            % Update the plots when user sorts the columns of the table
            updateplot(app);
        end

        % Button pushed function: AddButton
        function AddButtonPushed(app, event)
            x_add=app.XEditField.Value;
            y_add=app.YEditField.Value;
            co_add={x_add y_add};
            t=app.UITable.Data;
            app.UITable.Data=[t;co_add];
            updateplot(app);
        end

        % Button pushed function: LoadFromExelSheetButton
        function LoadFromExelSheetButtonPushed(app, event)
            % Read table array from file
            app.UITable.Data = readtable(app.ExcelSheetPathEditField.Value);
            updateplot(app);

        end

        % Button pushed function: ClearTableButton
        function ClearTableButtonPushed(app, event)
          app.UITable.Data=table([],[],'VariableNames',{'x','y'}) ;
            updateplot(app);
            app.ExcelSheetPathEditField.Value='';

        end

        % Value changed function: ModelDropDown
        function ModelDropDownValueChanged(app, event)
       
            updateplot(app);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create LinearregressionUIFigure and hide until all components are created
            app.LinearregressionUIFigure = uifigure('Visible', 'off');
            app.LinearregressionUIFigure.Position = [100 100 956 737];
            app.LinearregressionUIFigure.Name = 'Linear regression ';

            % Create UIAxes
            app.UIAxes = uiaxes(app.LinearregressionUIFigure);
            title(app.UIAxes, 'Original Data')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.Toolbar.Visible = 'off';
            app.UIAxes.FontName = 'Times New Roman';
            app.UIAxes.FontWeight = 'bold';
            app.UIAxes.FontSize = 20;
            app.UIAxes.Position = [246 255 636 453];

            % Create UITable
            app.UITable = uitable(app.LinearregressionUIFigure);
            app.UITable.ColumnName = {'x'; 'y'};
            app.UITable.RowName = {};
            app.UITable.ColumnSortable = [false false];
            app.UITable.ColumnEditable = [true true];
            app.UITable.DisplayDataChangedFcn = createCallbackFcn(app, @UITableDisplayDataChanged, true);
            app.UITable.FontName = 'Times New Roman';
            app.UITable.FontWeight = 'bold';
            app.UITable.FontSize = 20;
            app.UITable.Position = [28 255 207 453];

            % Create XEditFieldLabel
            app.XEditFieldLabel = uilabel(app.LinearregressionUIFigure);
            app.XEditFieldLabel.FontName = 'Times New Roman';
            app.XEditFieldLabel.FontSize = 20;
            app.XEditFieldLabel.FontWeight = 'bold';
            app.XEditFieldLabel.Position = [37 195 25 24];
            app.XEditFieldLabel.Text = 'X';

            % Create XEditField
            app.XEditField = uieditfield(app.LinearregressionUIFigure, 'numeric');
            app.XEditField.HorizontalAlignment = 'left';
            app.XEditField.FontName = 'Times New Roman';
            app.XEditField.FontSize = 20;
            app.XEditField.FontWeight = 'bold';
            app.XEditField.Position = [77 193 52 30];

            % Create YEditFieldLabel
            app.YEditFieldLabel = uilabel(app.LinearregressionUIFigure);
            app.YEditFieldLabel.FontName = 'Times New Roman';
            app.YEditFieldLabel.FontSize = 20;
            app.YEditFieldLabel.FontWeight = 'bold';
            app.YEditFieldLabel.Position = [140 196 25 24];
            app.YEditFieldLabel.Text = 'Y';

            % Create YEditField
            app.YEditField = uieditfield(app.LinearregressionUIFigure, 'numeric');
            app.YEditField.HorizontalAlignment = 'left';
            app.YEditField.FontName = 'Times New Roman';
            app.YEditField.FontSize = 20;
            app.YEditField.FontWeight = 'bold';
            app.YEditField.Position = [164 193 50 30];

            % Create AddButton
            app.AddButton = uibutton(app.LinearregressionUIFigure, 'push');
            app.AddButton.ButtonPushedFcn = createCallbackFcn(app, @AddButtonPushed, true);
            app.AddButton.FontName = 'Times New Roman';
            app.AddButton.FontSize = 20;
            app.AddButton.FontWeight = 'bold';
            app.AddButton.Position = [234 190 72 32];
            app.AddButton.Text = 'Add';

            % Create a0EditFieldLabel
            app.a0EditFieldLabel = uilabel(app.LinearregressionUIFigure);
            app.a0EditFieldLabel.HorizontalAlignment = 'right';
            app.a0EditFieldLabel.FontName = 'Times New Roman';
            app.a0EditFieldLabel.FontSize = 20;
            app.a0EditFieldLabel.FontWeight = 'bold';
            app.a0EditFieldLabel.Position = [427 202 25 24];
            app.a0EditFieldLabel.Text = 'a0';

            % Create a0
            app.a0 = uieditfield(app.LinearregressionUIFigure, 'numeric');
            app.a0.Editable = 'off';
            app.a0.FontName = 'Times New Roman';
            app.a0.FontSize = 20;
            app.a0.FontWeight = 'bold';
            app.a0.Position = [467 205 78 24];

            % Create a1EditFieldLabel
            app.a1EditFieldLabel = uilabel(app.LinearregressionUIFigure);
            app.a1EditFieldLabel.HorizontalAlignment = 'right';
            app.a1EditFieldLabel.FontName = 'Times New Roman';
            app.a1EditFieldLabel.FontSize = 20;
            app.a1EditFieldLabel.FontWeight = 'bold';
            app.a1EditFieldLabel.Position = [549 202 25 24];
            app.a1EditFieldLabel.Text = 'a1';

            % Create a1
            app.a1 = uieditfield(app.LinearregressionUIFigure, 'numeric');
            app.a1.Editable = 'off';
            app.a1.FontName = 'Times New Roman';
            app.a1.FontSize = 20;
            app.a1.FontWeight = 'bold';
            app.a1.Position = [589 205 78 24];

            % Create rEditFieldLabel
            app.rEditFieldLabel = uilabel(app.LinearregressionUIFigure);
            app.rEditFieldLabel.HorizontalAlignment = 'right';
            app.rEditFieldLabel.FontName = 'Times New Roman';
            app.rEditFieldLabel.FontSize = 20;
            app.rEditFieldLabel.FontWeight = 'bold';
            app.rEditFieldLabel.Position = [662 112 25 24];
            app.rEditFieldLabel.Text = 'r';

            % Create r
            app.r = uieditfield(app.LinearregressionUIFigure, 'numeric');
            app.r.Editable = 'off';
            app.r.FontName = 'Times New Roman';
            app.r.FontSize = 20;
            app.r.FontWeight = 'bold';
            app.r.Position = [702 115 79 24];

            % Create r2EditFieldLabel
            app.r2EditFieldLabel = uilabel(app.LinearregressionUIFigure);
            app.r2EditFieldLabel.HorizontalAlignment = 'right';
            app.r2EditFieldLabel.FontName = 'Times New Roman';
            app.r2EditFieldLabel.FontSize = 20;
            app.r2EditFieldLabel.FontWeight = 'bold';
            app.r2EditFieldLabel.Position = [788 111 36 24];
            app.r2EditFieldLabel.Text = 'r^2';

            % Create r_2
            app.r_2 = uieditfield(app.LinearregressionUIFigure, 'numeric');
            app.r_2.Editable = 'off';
            app.r_2.FontName = 'Times New Roman';
            app.r_2.FontSize = 20;
            app.r_2.FontWeight = 'bold';
            app.r_2.Position = [839 114 59 24];

            % Create s_rEditFieldLabel
            app.s_rEditFieldLabel = uilabel(app.LinearregressionUIFigure);
            app.s_rEditFieldLabel.HorizontalAlignment = 'right';
            app.s_rEditFieldLabel.FontName = 'Times New Roman';
            app.s_rEditFieldLabel.FontSize = 20;
            app.s_rEditFieldLabel.FontWeight = 'bold';
            app.s_rEditFieldLabel.Position = [415 112 32 24];
            app.s_rEditFieldLabel.Text = 's_r';

            % Create s_r
            app.s_r = uieditfield(app.LinearregressionUIFigure, 'numeric');
            app.s_r.Editable = 'off';
            app.s_r.FontName = 'Times New Roman';
            app.s_r.FontSize = 20;
            app.s_r.FontWeight = 'bold';
            app.s_r.Position = [462 115 78 24];

            % Create s_tEditFieldLabel
            app.s_tEditFieldLabel = uilabel(app.LinearregressionUIFigure);
            app.s_tEditFieldLabel.HorizontalAlignment = 'right';
            app.s_tEditFieldLabel.FontName = 'Times New Roman';
            app.s_tEditFieldLabel.FontSize = 20;
            app.s_tEditFieldLabel.FontWeight = 'bold';
            app.s_tEditFieldLabel.Position = [548 111 30 24];
            app.s_tEditFieldLabel.Text = 's_t';

            % Create s_t
            app.s_t = uieditfield(app.LinearregressionUIFigure, 'numeric');
            app.s_t.Editable = 'off';
            app.s_t.FontName = 'Times New Roman';
            app.s_t.FontSize = 20;
            app.s_t.FontWeight = 'bold';
            app.s_t.Position = [593 114 78 24];

            % Create ExcelSheetPathEditFieldLabel
            app.ExcelSheetPathEditFieldLabel = uilabel(app.LinearregressionUIFigure);
            app.ExcelSheetPathEditFieldLabel.HorizontalAlignment = 'right';
            app.ExcelSheetPathEditFieldLabel.FontSize = 20;
            app.ExcelSheetPathEditFieldLabel.FontWeight = 'bold';
            app.ExcelSheetPathEditFieldLabel.Position = [15 112 167 25];
            app.ExcelSheetPathEditFieldLabel.Text = 'Excel Sheet Path';

            % Create ExcelSheetPathEditField
            app.ExcelSheetPathEditField = uieditfield(app.LinearregressionUIFigure, 'text');
            app.ExcelSheetPathEditField.Position = [197 110 184 31];

            % Create LoadFromExelSheetButton
            app.LoadFromExelSheetButton = uibutton(app.LinearregressionUIFigure, 'push');
            app.LoadFromExelSheetButton.ButtonPushedFcn = createCallbackFcn(app, @LoadFromExelSheetButtonPushed, true);
            app.LoadFromExelSheetButton.FontSize = 20;
            app.LoadFromExelSheetButton.FontWeight = 'bold';
            app.LoadFromExelSheetButton.Position = [18 46 228 42];
            app.LoadFromExelSheetButton.Text = 'Load From Exel Sheet';

            % Create ModelDropDownLabel
            app.ModelDropDownLabel = uilabel(app.LinearregressionUIFigure);
            app.ModelDropDownLabel.FontSize = 20;
            app.ModelDropDownLabel.FontWeight = 'bold';
            app.ModelDropDownLabel.Position = [693 209 65 25];
            app.ModelDropDownLabel.Text = 'Model';

            % Create ModelDropDown
            app.ModelDropDown = uidropdown(app.LinearregressionUIFigure);
            app.ModelDropDown.Items = {'Linear', 'Exponential', 'Growth_Rate', 'Power'};
            app.ModelDropDown.ValueChangedFcn = createCallbackFcn(app, @ModelDropDownValueChanged, true);
            app.ModelDropDown.FontSize = 20;
            app.ModelDropDown.FontWeight = 'bold';
            app.ModelDropDown.Position = [773 205 147 37];
            app.ModelDropDown.Value = 'Linear';

            % Create ClearTableButton
            app.ClearTableButton = uibutton(app.LinearregressionUIFigure, 'push');
            app.ClearTableButton.ButtonPushedFcn = createCallbackFcn(app, @ClearTableButtonPushed, true);
            app.ClearTableButton.FontSize = 20;
            app.ClearTableButton.FontWeight = 'bold';
            app.ClearTableButton.Position = [254 46 126 42];
            app.ClearTableButton.Text = 'Clear Table';

            % Create aLabel
            app.aLabel = uilabel(app.LinearregressionUIFigure);
            app.aLabel.HorizontalAlignment = 'right';
            app.aLabel.FontName = 'Times New Roman';
            app.aLabel.FontSize = 20;
            app.aLabel.FontWeight = 'bold';
            app.aLabel.Position = [422 60 25 24];
            app.aLabel.Text = 'a';

            % Create a
            app.a = uieditfield(app.LinearregressionUIFigure, 'numeric');
            app.a.Editable = 'off';
            app.a.FontName = 'Times New Roman';
            app.a.FontSize = 20;
            app.a.FontWeight = 'bold';
            app.a.Position = [462 63 78 24];

            % Create bLabel
            app.bLabel = uilabel(app.LinearregressionUIFigure);
            app.bLabel.HorizontalAlignment = 'right';
            app.bLabel.FontName = 'Times New Roman';
            app.bLabel.FontSize = 20;
            app.bLabel.FontWeight = 'bold';
            app.bLabel.Position = [556 63 25 24];
            app.bLabel.Text = 'b';

            % Create b
            app.b = uieditfield(app.LinearregressionUIFigure, 'numeric');
            app.b.Editable = 'off';
            app.b.FontName = 'Times New Roman';
            app.b.FontSize = 20;
            app.b.FontWeight = 'bold';
            app.b.Position = [596 66 78 24];

            % Show the figure after all components are created
            app.LinearregressionUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = TableDataAppExample_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.LinearregressionUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.LinearregressionUIFigure)
        end
    end
end