#!/usr/bin/perl 
use Net::SNMP;
use DBI;
use DBD::mysql;
use Cwd 'abs_path';
my $abs_path = abs_path(__FILE__);
@path=split '/',$abs_path;
splice @path,-2;
push (@path,"db.conf");
$actualpath=join('/',@path);
require "$actualpath";



 my $OID_sysUpTime = '1.3.6.1.2.1.1.3.0';
   my $OID_sysContact = '1.3.6.1.2.1.1.4.0';
   my $OID_sysLocation = '1.3.6.1.2.1.1.6.0';


$dbh = DBI->connect("DBI:mysql:database=$database;host=$host;port=$port", $username,$password);

$sql="CREATE TABLE IF NOT EXISTS UPTIMES (
id int(30) NOT NULL primary key auto_increment,
 IP varchar(255) NOT NULL ,
 PORT int(30) NOT NULL,
 COMMUNITY varchar(255) NOT NULL,
 
 sysuptime varchar(255) NOT NULL,
 syscontact varchar(255) NOT NULL,
  syslocation varchar(255) NOT NULL,
sentreq int NOT NULL,
reqlost int NOT NULL,
lastupdate varchar(255) NOT NULL,
UNIQUE KEY(IP,PORT,COMMUNITY)
 
         ) ";
$sth =$dbh->prepare($sql);

$sth->execute();
$sth->finish();
$dbh->do("insert into UPTIMES (IP,PORT,COMMUNITY) select DEVICES.IP,DEVICES.PORT,DEVICES.COMMUNITY from DEVICES on duplicate key update IP=UPTIMES.IP");
$dbh = DBI->connect("DBI:mysql:database=$database;host=$host;port=$port",$username,$password) or die "Unable to connect: $DBI::errstr\n";
 $query="select *from DEVICES";
$query_handle = $dbh->prepare($query);
 





$query_handle->execute();

	while(@row=$query_handle->fetchrow())
	{
	($id,$IP,$port,$community)=@row;

	


	
	$time=localtime();


	 # Hash of hosts and location data.

	      my ($session, $error) = Net::SNMP->session(
		 -hostname    =>$IP,
		 -port          => $port,
		 -community   => $community,
		 -nonblocking => 1,
                 -timeout       => 1,
	      );
			
	      if (!defined $session) {
		 printf "ERROR: Failed to create session for host '%s': %s.\n",
		        $host, $error;
		 next;
	      }
	my $sth=$dbh->prepare("update UPTIMES SET sentreq = sentreq+1,lastupdate='$time' WHERE IP='$IP' AND PORT='$port' AND COMMUNITY='$community'");
	$sth->execute();
	$sth->finish();
	      my $result = $session->get_request(
	  
		 -varbindlist => [$OID_sysUpTime,$OID_sysContact,$OID_sysLocation] ,
		 -callback    => [ \&get_callback ,$IP,$port,$community],
	      );

	      if (!defined $result) {

		 printf "ERROR: Failed to queue get request for host '%s': %s.\n",
		        $session->hostname(), $session->error();
		       
	      }						
	}




   # Now initiate the SNMP message exchange.
   snmp_dispatcher();

   

   sub get_callback
   {


      my ($session,$IP,$port,$community) = @_;


      my $result = $session->var_bind_list();


      if (!defined $result) {
my $sth=$dbh->prepare("update UPTIMES SET reqlost = reqlost+1 WHERE IP='$IP' AND PORT='$port' AND COMMUNITY='$community'");
$sth->execute();
$sth->finish();
         printf "ERROR: Get request failed for host '%s': %s.\n",
                $session->hostname(), $session->error();
         
      }
     
	else{
      print "The sysUpTime for host" . $session->hostname() . $result->{$OID_sysUpTime} . "\n";


my $sth=$dbh->prepare("update UPTIMES SET sysuptime='$result->{$OID_sysUpTime}',syscontact='$result->{$OID_sysContact}',syslocation='$result->{$OID_sysLocation}' WHERE IP='$IP' AND PORT='$port' AND COMMUNITY='$community'");
$sth->execute();
$sth->finish();

	}
}
   


  

