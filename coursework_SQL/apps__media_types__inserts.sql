

SELECT * FROM `apps`;	
SELECT * FROM `media_types` ORDER BY id;


INSERT INTO `apps` 
            (`id`, `name`          )
	 VALUES ( 1  , 'y_tv'          ),
	        ( 2  , 'y_music'       ),
	        ( 3  , 'y_for_children'),
	        ( 4  , 'y_creators'    );
	        
   
INSERT INTO `media_types`
            (`id`, `app_id`, `name`				)
     VALUES 
-- --------- y_tv (tv channels) -------------------------
			( 1  ,  1      , 'abc' 				),
	        ( 2  ,  1      , 'cbs' 				),
			( 3  ,  1      , 'fox' 				),
			( 4  ,  1      , 'nbc' 				),
			( 5  ,  1      , 'abc_news' 		),
			( 6  ,  1      , 'accn' 			),
			( 7  ,  1      , 'amc'  			),
			( 8  ,  1      , 'adult_swim' 		),
			( 9  ,  1      , 'animal_planet' 	),
			( 10 ,  1      , 'bbc' 				),
			( 11 ,  1      , 'bbc_world_news' 	),
			( 12 ,  1      , 'bet' 				),
			( 13 ,  1      , 'btn' 				),
			( 14 ,  1      , 'bravo' 			),
-- --------- y_music (music genres) ---------------------			
			(101 ,  2      , 'rock'				),
			(102 ,  2      , 'hip-hop'			),			
			(103 ,  2      , 'metal'			),			
			(104 ,  2      , 'electronic'		),
			(105 ,  2      , 'energy'			),
			(106 ,  2      , 'romantic'			),
			(107 ,  2      , 'pop'				),
			(108 ,  2      , '2010-th'			),
			(109 ,  2      , 'good_mood'		),
			(110 ,  2      , 'seasoned'			),
			(111 ,  2      , '1970-th'			),
			(112 ,  2      , 'in_transport'		),
			(113 ,  2      , 'party'			),
			(114 ,  2      , 'r&b_soul'			),
			(115 ,  2      , '1990-th'			),
			(116 ,  2      , 'for_fitnes'		),
			(117 ,  2      , 'folk'				),
			(118 ,  2      , 'alternative'		),
			(119 ,  2      , 'for_kids'			),
			(120 ,  2      , 'jazz'				),
			(121 ,  2      , '1980-th'			),
			(122 ,  2      , 'latina'			),
			(123 ,  2      , 'blues'			),
			(124 ,  2      , 'soundtracks'		),
			(125 ,  2      , '1950-th'			),
			(126 ,  2      , '1960-th'			),
			(127 ,  2      , 'concentration'	),
			(128 ,  2      , 'for_sleep'		),
			(129 ,  2      , 'classic'			),
			(130 ,  2      , 'country_music'	),
			(131 ,  2      , 'reggae'			),
			(132 ,  2      , 'bollywood'		),
			(133 ,  2      , 'asian'			),
			(134 ,  2      , 'african'			),
-- --------- y_for_children -----------------------------			
			(201 ,  3      , 'show'				),
			(202 ,  3      , 'music'			),
			(203 ,  3      , 'study'			),
			(204 ,  3      , 'navigator'		),
-- --------- y_creators (for channel creators) ----------
			(301 ,  4      , 'branded_content'		),
			(302 ,  4      , 'author_rights'		),
			(303 ,  4      , 'upstage'				),
			(304 ,  4      , 'musician_oportunities'),
			(305 ,  4      , 'partner_oportunities'	),
			(306 ,  4      , 'ready_for_income'		),
			(307 ,  4      , 'partner_programm'		),
			(308 ,  4      , 'honest_content_using'	),
			(309 ,  4      , 'content_defence'		);
			
		
		
		