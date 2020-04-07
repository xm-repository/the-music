;(function($){

	var fnName = 'audioPlay';
	var config = {

		view : ".audio-view",

		songName : ".audio-title",

		pictureSrc : ".audio-cover",

		autoPlay : false,

		songIndex : 0,

		volume : {

			volumeView : ".audio-set-volume",
			volumeBox : ".volume-box",
		},

		timeView : {

			thisTime : ".audio-this-time",

			countTime : '.audio-count-time',
		},

		setbacks : {

			setbacks : '.audio-setbacks',

			thisSetbacks : '.audio-this-setbacks',

			cacheSetbacks : ".audio-cache-setbacks",

			volumeSetbacks : ".volume-box > i",

			volumeCircular : ".volume-box > i span"
		},

		button : {

			volume : ".audio-volume",

			backs : ".audio-backs-btn",

			prev : ".audio-prev",

			play : ".audio-play",

			next : ".audio-next",

			menu : ".audio-menu",

			menuClose : ".menu-close"
		},

		menu : {

			menuView : '.audio-list',

			colse : '.close',

			list : '.audio-inline'
		},

		song : null
	};

	var songEq = 0,
		volumeSize = 0.7;

	window[fnName] = function(setConfig){

		songEq = setConfig.songIndex;
		//设置属性值
		if(typeof(setConfig) == "object"){

			for( var n in setConfig){

				config[n] = setConfig[n];
			}
		}


		var _this = config,
			playDate;

		var pictureSrc = $(_this.pictureSrc),
			songName = $(_this.songName),
			thisTime = $(_this.timeView.thisTime),
			countTime = $(_this.timeView.countTime),
			thisSetbacks = $(_this.setbacks.thisSetbacks),
			cacheSetbacks = $(_this.setbacks.cacheSetbacks),
			setbacks = $(_this.setbacks.setbacks),
			volumeCircular = $(_this.setbacks.volumeCircular),
			volumeSetbacks = $(_this.setbacks.volumeSetbacks),
			volumeBox = $(_this.volume.volumeBox),
			play = $(_this.button.play),
			prev = $(_this.button.prev),
			next = $(_this.button.next),
			menuBtn = $(_this.button.menu),
			volume = $(_this.button.volume),
			menuClose = $(_this.button.menuClose),
			backs = $(_this.button.backs);

		_this.createAudio = function(){

			if(!_this.audio){
				_this.audio = new Audio();
			}

			var song = config.song;
			if(!song){
				alert('当前歌单没有歌曲!!!');
				return false;
			}

			_this.stopAudio();


			_this.audio.src = song[songEq].songSrc;

			//记录当前播放的songId
			$(_this.audio).attr("songEq",songEq);
			//页面title变化
			$("title").text(song[songEq].songName+" - "+song[songEq].singerName+" - The Music-千万曲库新歌热歌天天畅听的高品质音乐平台！");
			_this.volumeSet();

			songName.text(song[songEq].songName || '未知歌曲');
			pictureSrc.css({
				'backgroundImage' : 'url('+(song[songEq].pictureSrc || '')+')'
			});

			function setDuration(){

				if(isNaN(_this.audio.duration)){

					setTimeout(setDuration,50);
				}else{

					countTime.text(_this.conversion(_this.audio.duration));
				}
			}
			setDuration(_this.audio.duration);

			thisTime.text(_this.conversion(_this.audio.currentTime));

			_this.audio.onended = function(){

				setTimeout(function(){

					++songEq;
					songEq = (songEq < _this.song.length) ? songEq : 0;
					_this.selectMenu(songEq,true);
				},1000);
			}

		}

		var timeAudio;
		_this.playAudio = function(){

			if(_this.audio){

				if(!playDate || (Date.now() - playDate) > 100){

					playDate = Date.now();

					(!_this.audio.paused) || _this.audio.pause();

					_this.audio.play();
					play.addClass('audio-stop').one('click',function(){

						_this.stopAudio();
						$(this).removeClass('audio-stop').one('click',function(){

							_this.playAudio();
						});
					});

					timeAudio = setInterval(function(){

						if(_this.audio.readyState == 4){

							cacheSetbacks.css({
								'width' : (_this.audio.buffered.end(0) / _this.audio.duration)*100+"%"
							});
						}

						thisSetbacks.css({
							'width' : (_this.audio.currentTime / _this.audio.duration)*100+"%"
						});

						thisTime.text(_this.conversion(_this.audio.currentTime));
					},500);
				}else{

					setTimeout(function(){

						_this.playAudio();
					},50);
				}
			}
		}

		_this.stopAudio = function(){

			//改变图片
			play.removeClass('audio-stop');
			if(!playDate || (Date.now() - playDate) > 100){

				playDate = Date.now();
				_this.audio.pause();
				clearInterval(timeAudio);
			}else{

				setTimeout(function(){

					_this.stopAudio();
				},50);
			}
		}

		_this.conversion = function(num){

			function changInt(num){

				return (num < 10) ? '0'+num : num;
			}

			return changInt(parseInt(num/60))+":"+ changInt(Math.floor(num%60));
		}



		_this.selectMenu = function(num,_bool){
			songEq = num;
			_this.createAudio();
			(_bool) && _this.playAudio();
		}

		_this.volumeSet = function(){

			_this.audio.volume = volumeSize;
			volumeSetbacks.css({
				'height' : volumeSize*100 + "%"
			});
		}

		_this.newSong = function(_new,_bool){

			if( typeof(_new) == 'object' ){

				if(_new.songSrc){

					if(_this.song){

						_this.song.push(_new);
					}else{

						_this.song = [_new];
					}

					_this.upMenu();
					(_bool) && _this.selectMenu(_this.song.length-1,true);
				}else{

					alert('对象缺省src属性');
				}
			}else{

				alert('这不是一个对象');
			}
		}

		var volumeTime;
		volumeBox.on('mousedown',function(){

			if(_this.audio){
				var Y,EndY = parseInt(volumeBox.css('height')),goY;
				volumeBox.on('mousemove click',function(e){

					clearTimeout(volumeTime);

					Y = (e.clientY-(volumeBox.offset().top-$(document).scrollTop()));
					Y = (Y > 0) ? (Y > EndY) ? EndY : Y : 0;

					goY = Y/EndY;

					volumeSize = 1 - goY;

					_this.volumeSet();
				});

				volumeBox.one('mouseup',function(){

					volumeBox.unbind('mousemove');
				}).on('mouseout',function(){

					volumeTime = setTimeout(function(){

						volumeBox.unbind('mousemove');
					},500);
				});
			}
		});

		setbacks.on('mousedown',function(){

			if(_this.audio){
				var X,EndX = parseInt(setbacks.css('width')),goX,mouseTime;
				setbacks.on('mousemove click',function(e){

					_this.stopAudio();
					clearTimeout(mouseTime);

					X = (e.clientX-setbacks.offset().left);
					X = (X > 0) ? (X > EndX) ? EndX : X : 0;

					goX = X/EndX;
					thisSetbacks.css({
						'width' : goX*100+"%"
					});

					_this.audio.currentTime = parseInt(goX*_this.audio.duration);
					thisTime.text(_this.conversion(_this.audio.currentTime));
				});

				setbacks.one('mouseup',function(){

					_this.playAudio();
					setbacks.unbind('mousemove');
				}).on('mouseout',function(){

					mouseTime = setTimeout(function(){

						_this.playAudio();
						setbacks.unbind('mousemove');
					},500);
				});
			}
		});

		play.one('click',function(){

			_this.playAudio();
		});

		menuBtn.on('click',function(){

			$(_this.menu.menuView).toggleClass('menu-show');
		});

		prev.on('click',function(){

			--songEq;
			songEq = (songEq >= 0) ? songEq :  _this.song.length -1;
			_this.selectMenu(songEq,true);
		});

		next.on('click',function(){

			++songEq;
			songEq = (songEq < _this.song.length) ? songEq : 0;
			_this.selectMenu(songEq,true);
		});

		menuClose.on('click',function(){

			$(_this.menu.menuView).removeClass('menu-show');
		});

		volume.on('click',function(){

			$(_this.volume.volumeView).toggleClass('audio-show-volume');
		});


		_this.selectMenu(songEq,_this.autoPlay);

		return _this;
	}
})(jQuery)