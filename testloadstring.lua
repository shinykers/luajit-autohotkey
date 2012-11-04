eventData = [[
months = {
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
}
]]

loadstring(eventData)()
if months then
    print(table.concat(months, ", "))
end