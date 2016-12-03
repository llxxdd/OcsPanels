<?php

class Login extends Controller {

	function In($f3) {
		if ($f3->exists('SESSION.id')) $f3->reroute('/home');
		$f3->set('content','login.html');
	}

	function Post($f3) {
		$name = $f3->get('POST.username');
		$pass = $f3->get('POST.password');
		$user = new \User;
		$user->load(array('username=?',$name));
		if ( ! $user->dry()) {
			if ( ! $user->active == 1) {
				$this->flash('Your account is temporarily locked');
				$f3->reroute('/');
			}
			elseif (Check::pass($pass, $user->password)) {
				$f3->set('SESSION.id',$user->id);
				$f3->reroute('/home');
			}
		}
		$this->flash('Username atau password salah');
		$f3->reroute('/');
	}

	function Out($f3) {
		$f3->clear('SESSION');
		$f3->reroute('/');
	}

}