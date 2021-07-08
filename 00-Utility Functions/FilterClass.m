classdef FilterClass < handle
    % FilterClass is a generic N-th order digital filter that filters M-numbers of signals. 
    % The m-th row of coefficients are the filter coefficients for the m-th signal.
    % The columns of coefficients are the coefficients of a N-th order filter with states arranged in the order of 
    % [input(k), input(k-1), ... input(k-N), output(k-1), ... output(k-N)] with k being the current stage. 
    % The coefficients should sum to 1. 
    % 
    % Signals are filtered by FilterClass.Filter(Input)
    % The filtered output is computed as:
    % output(k) = C(1)*input(k) + C(2)*input(k-1) + ... + C(N+1)*input(k-N) + C(N+1+1)*output(k-1) + ... + C(2N+1)*output(k-N)]
    % Or in the form of discrete Laplace domain z:
    % Output(z) = C(1)*Input(z) + C(2)*Input(z)*z^-1 + ... + C(N+1)*Input(z)*z^-N + C(N+1+1)*Output(z)*z^-1 + ... + C(2N+1)*Output(z)*z^-N]
    %
    % Coefficients can be altered after the creation of a FilterClass object by FilterClass.SetCoeff(Coeff).
    % The filter's previous states can be reset to specified values by FilterClass.ResetFilter(Value).
    %
    % Properties - are member variables and/or objects of the class
    %
    %
    % private access by class members only (not from subclasses)
    % immutable property can be set only in the constructor.
    %
    properties (GetAccess = private, SetAccess = immutable)
        % The order of the filter, this should never be changed once a
        % instance of FilterClass is instantiated
        FilterOrder
    end
    %
    % private set access by class members only (not from subclasses)
    % public get access for testing
    % 
    properties (GetAccess = public, SetAccess = private)
        % Coefficients of the filter with size M x N*2+1, this can be changed after the creation of a FilterClass object.
        FilterCoeff
        % Previous output states with size M x N.
        OutputPrev 
        % Previous input states with size M x N.
        InputPrev        
    end
    
    %
    % Methods - are member function of the class
    %
    methods
        %
        % Constructor - Constructs a FilterClass with Coeff
        %
        function self = FilterClass(Coeff)
            if nargin < 1
                error('FilterClass Not Initialized')
            end            
            self.FilterCoeff = Coeff;
            
            % The order of the filter is (number of columns in Coeff - 1)/2
            % Filter order must be greater than 1
            N = (size(Coeff,2)-1)/2;
            if N > 0
                self.FilterOrder = N;
            else
                error('FilterClass::Filter order must be greater than 1')
            end         
            
            % Initialize filter states to zeros.
            M = size(Coeff,1);
            self.OutputPrev = zeros(M, N);
            self.InputPrev = zeros(M, N);
        end
        %
        % Getter function for testing this class. VariableString is a string matching one of properties in this class.
        %
        function Value = Get(self, VariableString)
            Value = self.(VariableString);
        end
        %
        % Set/Change filter coefficient to Coeff
        %        
        function SetCoeff(self, Coeff)
            % Check to make sure Coeff is on the same order of the initialized filter's order.
            if (size(Coeff,2)-1)/2 == self.FilterOrder
                self.FilterCoeff = Coeff;
            else
                error('FilterClass::SetCoeff: Input coefficient is a different order of filter than the initailized filter')
            end
        end
        %
        % Reset filter states to Value
        %
        function ResetFilter(self, Value)
            % Loop through all the components of signal in the vector (Value).
            for m = 1:length(Value)
                % Loop through all the previous filter states and set them to the corresponding components of Value.
                for n = 1:self.FilterOrder
                    self.OutputPrev(m,n) = Value(m);
                    self.InputPrev(m,n) = Value(m);
                end
            end
        end
        %
        % Filter Input
        %
        function Output = Filter(self, Input)
            
            % Filter input:
            Output = sum(self.FilterCoeff .* [Input, self.InputPrev, self.OutputPrev] ,2);
            
            % Store filter states,..., previous states to previous previous states, and current states to previous states:
            % Loop through the previous states starting from the state with highest degree of memory and 
            % update the state with state that is 1 degree of memory forward.
            for n = self.FilterOrder:-1:1
                if n == 1
                    self.OutputPrev(:,n) = Output;
                    self.InputPrev(:,n) = Input;
                else
                    self.OutputPrev(:,n) = self.OutputPrev(:,n-1);
                    self.InputPrev(:,n) = self.InputPrev(:,n-1);
                end
            end
            
        end
        
    end
    
end

