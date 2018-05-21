 <?php
 
 if ($_SERVER['REQUEST_METHOD'] === 'POST')
	{
		$email = filter_input(INPUT_POST, 'email');
		$pass = filter_input(INPUT_POST, 'pass');
		
		if (($email == 'username') && ($pass == 'password'))  
			{
				echo "CNDP3DHAVAL_BHARODIYA_SHALIN_MOMIN_PRAKASH_MAKHIJANI";
			}
		else 
			{
				echo "INVALID";
			}
	}
	else 
	{
		echo "Invalid request";
	}
?>