PoshZD
=============
[![Build status](https://ci.appveyor.com/api/projects/status/86ph4p43kcakx40x?svg=true)](https://ci.appveyor.com/project/MSAdministrator/poshzd)

A PowerShell Module to interact with the ZenDesk ticketing system.

This is a work in progress and has had limited testing 
Pull requests and other contributions would be welcome!

# Instructions


### One time setup
    # Download the repository
    # Unblock the zip
    # Extract the PoshZD folder to a module path (e.g. $env:USERPROFILE\Documents\WindowsPowerShell\Modules\)

### Import the module.
    Import-Module PoshZD

### Get commands in the module
    Get-Command -Module PoshZD

# Prerequisites

* PowerShell 3 or later
* A valid token from ZenDesk API or your User Name and Password (Coming Soon)

# Examples

### Create a new ZenDesk Ticket

```powershell
# This example shows how to create a ZenDesk Ticket Object that can be used to create a ZenDesk ticket


#Create your ZenDesk Headers and Domain variables
Set-ZDHeader -Email 'first.last@domain.com' -Token 'zendesktokengoeshere'
Set-ZDDomain -Domain 'domain' #example of domain is https//:{domain}.zendesk.com

$ZDObject = Create-ZDTicketObject -String 'New Ticket for customer' `
                                  -Description 'Orgnization has issues with software' `
                                  -Comment 'creating ticket for orgnization because of issues with software' `
                                  -Type incident `
                                  -Priority high `
                                  -Status new
```
### Create new ZenDesk ticket
```powershell
$ZDObject | New-ZDTicket
```
### Update ZenDesk ticket
```powershell
$ZDObject | Update-ZDTicket -TicketNumber 123456789
or
$ZDTicket = Get-ZDTicket -TicketId 123456789
Update-ZDTicket -TicketId $ZDTicket -TicketObject $ZDObject
```
#### This README is a work in progress.  There is similar functionality across all functions which include 
#### Tickets, Users, Organizations, and Attachments
#### More functionality will continue to be added.
