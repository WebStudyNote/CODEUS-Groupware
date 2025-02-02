<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>

<link rel="stylesheet" href="${contextPath}/resources/assets/vendor/summernote/summernote-lite.css">



<style>
        table th {
            font-size: 15px;}
            
            
		   label {
		   	color : black;
		   }   
		   
		   p {
		   	color : black;
		   }   
		   
            
</style>
</head>

<body>
    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">	

		<c:import url="../common/menubar.jsp"/>
	<div class="content-body">
        <div class="container-fluid">
	         <div class="row">
	             <div class="col-12">
	                  <div class="card">
	                        <div class="card-body">
							 <!-- 본문 시작 -->
								<h3 style="width: 200px; height: 30px;">자유게시판</h3>
								<br>
								<p>*불쾌함을 주는 내용이나 광고성 게시글은 관리자에 의해 삭제될 수 있습니다.</p>
									<div class='market-insert-form'>
						   				<form action="binsert.bo" method="post" enctype="Multipart/form-data">	 
									      <table class="table table-write" id="add_mt" style="color:black ">
											<colgroup>			
											<col style="width:120px" />
											<col style="width:*" />						
											</colgroup>
											
											<tr>						
												<th>제목</th>
												<td><input type="text" class="form-control" id="bTitle" 
													name="bTitle" placeholder="제목" value="${title}" required></td>
											</tr>
											<tr>
												<th>작성자</th>
												<td><input type="text" class="form-control" 
														id="bWriter" name="bWriter" readonly value="${ sessionScope.loginUser.mId }"></td>
											</tr>
											<tr>
											<th>내용</th>
												<td><div class="container">
													  <textarea id="summernote" class="summernote" name="bContent" ></textarea>
												 </div></td>
											</tr>
						                              		
						                   <tr> 
						                       <td colspan ="4" style="text-align: center;">
						                       		<input type="submit" value="등록" id="bSubmit" class="btn btn-primary">
													<button type="button" onclick="location.href='Commblist.bo'" class="btn btn-primary">취소</button>
												</td>
											</tr>		
										</table>
							  		</form>
								</div>
							</div>
							</div>
							     </div>
							      	</div>
							   			 </div>
							  				</div>
			 			

		</div>
	 <!--**********************************
            Content body end
        ***********************************-->
    
		<!--**********************************
		       Summernote  Scripts
		***********************************-->
 	<script src="${contextPath}/resources/assets/vendor/summernote/summernote-lite.js"></script>
		<script src="${contextPath}/resources/assets/vendor/summernote/lang/summernote-ko-KR.js"></script>
                      	<script>
        $(document).ready(function () {
            //여기 아래 부분
            $('#summernote').summernote({
                height: 400,                     // 에디터 높이
                 minHeight: null,                      // 최소 높이
                 maxHeight: null,                      // 최대 높이
                focus: false,                       // 에디터 로딩후 포커스를 맞출지 여부
                lang: "ko-KR",                  // 한글 설정
                placeholder: '내용을 입력해주세요.',   //placeholder 설정
                codemirror: { // codemirror options
                    theme: 'monokai'
                },
                /*   callbacks: {	//여기 부분이 이미지를 첨부하는 부분
                         onImageUpload : function(files) {
                             uploadSummernoteImageFile(files[0],this);
                         }
                     }, */
                toolbar: [
                    // [groupName, [list of button]]
                    ['fontname', ['fontname']],
                    ['fontsize', ['fontsize']],
                    ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
                    ['color', ['color']],
                    ['table', ['table']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                    ['insert', ['picture', 'link', 'video']],
                    ['view', ['fullscreen', 'help']]
                ],
                fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋음체', '바탕체'],
                fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72']
            });
        });
        /**
        * 이미지 파일 업로드
        */
        function uploadSummernoteImageFile(file, editor) {
            data = new FormData();
            data.append("file", file);
            $.ajax({
                data: data,
                type: "POST",
                url: "/uploadSummernoteImageFile",
                contentType: false,
                processData: false,
                success: function (data) {
                    //항상 업로드된 파일의 url이 있어야 한다.
                    $(editor).summernote('insertImage', data.url);
                }
            });
        }
		
    </script>


<!--     <script> -->
//         //서머노트에 text 쓰기
//         $('#summernote').summernote('insertText');
//         // 서머노트 쓰기 활성화
//         $('#summernote').summernote('enable');
//         // 서머노트 리셋
//         $('#summernote').summernote('reset');
//         // 마지막으로 한 행동 취소 ( 뒤로가기 )
//         $('#summernote').summernote('undo');
//         // 앞으로가기
//         $('#summernote').summernote('redo');
<!--     </script> -->

		                            	
        <!--**********************************
            Footer start
        ***********************************-->
        <div class="footer">
            <div class="copyright">
                <p>Copyright © Designed &amp; Developed by <a href="${contextPath}/home.do" target="_blank">CODEUS</a> 2021</p>
            </div>
        </div>
        <!--**********************************
            Footer end
        ***********************************-->      
          
    
    <!--**********************************
        Main wrapper end
    ***********************************-->
    
   <!--**********************************
        Scripts
    ***********************************-->

    
   <!-- Tree Viewer JS
	============================================ -->
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script> -->


</body>

</html>