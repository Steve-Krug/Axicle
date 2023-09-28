selection = nbuttondlg('Select Model and Axle:',{'S Front','S Rear','X Front','X Rear'});
if contains(selection,'S ')
    model = 'S';
elseif contains(selection,'X ')
    model = 'X';
else
    error('No matching vehicle selected.')
end
if contains(selection,'Front')
    axle = 'Front';
elseif contains(selection,'Rear')
    axle = 'Rear';
else
    error('Unknown axle selected.')
end