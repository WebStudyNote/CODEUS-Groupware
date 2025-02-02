<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고 게시판 </title>


<<!-- summernote CSS
		============================================ -->
	<link rel="stylesheet" href="${contextPath}/resources/assets/vendor/summernote/summernote-lite.css">



  <!-- <script>
      //서머노트에 text 쓰기
      $('#summernote').summernote('insertText');
      // 서머노트 쓰기 활성화
      $('#summernote').summernote('enable');
      // 서머노트 리셋
      $('#summernote').summernote('reset');
      // 마지막으로 한 행동 취소 ( 뒤로가기 )
      $('#summernote').summernote('undo');
      // 앞으로가기
      $('#summernote').summernote('redo');
  </script> -->
	
<style>
     

     .fileArea {
       width: 100%;
 	 }

   .fileArea ul {
       display: flex;
       flex-flow: row;
       justify-content: center;
       align-items: center;
       padding: 0;
   }

   .fileArea ul li {
       list-style: none;
       padding: 10px;
   }

   .fileArea ul li img {
       width: 100px;
   }
   
   .fileArea ul li span {color: dimgray;}
   
   
   
   label {
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
    
        <!--**********************************
            Content body start
        ***********************************-->
   <div class="content-body">
        <div class="container-fluid">
         <div class="row">
             <div class="col-12">
                  <div class="card">
                        <div class="card-body">
						 <!-- 본문 시작 -->
							<h4 style="width: 200px; height: 30px;">중고게시판</h4>
							<br>
								<p>*불쾌함을 주는 내용이나 광고성 게시글은 관리자에 의해 삭제될 수 있습니다.</p>
								<div class='market-insert-form'>
									<form id="insertForm" action = "marketInsert.bo" class="frm_market_insert" name="frm_market_insert" method="post" enctype="multipart/form-data" >
										<div class="form-group row">
								   		 <label for="mbWriter" class="col-sm-2 col-form-label  is-invalid">작성자</label>
										    <div class="col-sm-8">
										      <input type="text" class="form-control "  name="mbWriter"required readonly value="${ sessionScope.loginUser.mId }"> 
										    </div>
										  </div>
										<div class="form-group row">
								   		 <label for="mbTitle" class="col-sm-2 col-form-label  is-invalid">상품명</label>
										    <div class="col-sm-8">
										      <input type="text" class="form-control "  id="bTitle" name="mbTitle" required placeholder="상품명 및 제목을 입력하세요.">
										    </div>
										  </div>
										  
										<div class="form-group row">
								   		 <label for="marketaCate" class="col-sm-2 col-form-label">카테고리</label>
										    <div class="col-sm-8">
						   					 <select class="form-control " name="mbCategory"  required>
													<option value="전체">카테고리</option>
													<option value="의류/미용">의류/미용</option>
													<option value="전자제품">전자제품</option>
													<option value="도서/티켓">도서/티켓</option>
													<option value="기타 중고물품">기타 중고물품</option>
												</select>				   
												</div>
										  	</div>
										<div class="form-group row">
								   		 <label for="marketPrice" class="col-sm-2 col-form-label">판매가격</label>
										    <div class="col-sm-8" style="display : inline-block;">
										    	  <div style="display:flex;">
										    	  <input type="text" class="form-control" name="marketPrice" id="marketPrice" onkeyup="wonComma(this.value)" placeholder="0" style="text-align : right;" required>
										    	  <span class="input-group-text">원</span>
										    	</div>
										    </div>
										  </div>
										</div>
										  <div class="form-group row">
								   		 <label for="mbContent" class="col-sm-2 col-form-label">내용</label>
										    <div class="container">
							 					 <textarea id="summernote" class="summernote" name="mbContent" ></textarea>
											</div>
										  </div>
										  <div class="col-lg-12">
										      <div class="card shadow mb-4">
										         <div class="card-header py-3">
										            <h4 class="m-0 font-weight-bold text-primary">대표사진을 선택해주세요</h4>
										         </div>
										         <div class="card-body">
										            <div class="form-group uploadDiv">
										               <!-- 첨부파일 시작 -->
														<div id="fileArea">
															<input type="file" id="imageFile" name="uploadFile" accept="image/gif, image/jpeg, image/png"/>
														</div>
															 <div class="select_img"><img src="" /></div>
															 
															 <script>
															  $("#imageFile").change(function(){
															   if(this.files && this.files[0]) {
															    var reader = new FileReader;
															    reader.onload = function(data) {
															     $(".select_img img").attr("src", data.target.result).width(500);        
															    }
															    reader.readAsDataURL(this.files[0]);
															   }
															  });
															  
															 </script>
															</div>
														
														<!-- 첨부파일 끝 -->
													</div>
													</div>
										         </div>
										      </div>
											</div>
										 <div class="market-btn-zone" align="center">
										<input class="btn btn-primary" type="submit"   id = 'btnSave' value="등록">
										<input class="btn btn-primary" type = 'button' value = '취소' onclick = "golist();">
									</div>
								</form>
							</div>
						<!-- 본문 끝-->
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

<script>
var imgFile = $('#imageFile').val();
var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
var maxSize = 5 * 1024 * 1024;
var fileSize;

	$('#btnSave').on('click', function() {
        if($('#bTitle').val().trim()==''){
            alert("제목이 비어있습니다.");
            $('#bTitle').focus();
            return false;
        } else if( $('#marketPrice').val()=='') {
            alert("가격을 입력해주세요.");
            $('#marketPrice').focus();
            return false;         
            
        } else if( $('#summernote').val()=='') {
            alert("내용이 비어있습니다.");
            $('#summernote').focus();
            return false;
       
        } else if($('#imageFile').val() == "") {
        	alert("대표사진 첨부는 필수입니다!");
            $("#imageFile").focus();
            return false;
            
        } else if(imgFile != "" && imgFile != null) {
        	fileSize = document.getElementById("imageFile").files[0].size;
            
            if(!imgFile.match(fileForm)) {
            	alert("이미지 파일만 업로드 가능");
                return;
            } else if(fileSize = maxSize) {
            	alert("파일 사이즈는 5MB까지 가능");
                return;
            }
        }else {
            $("#insertForm").first().submit();
        }
});			
			

</script>	
	
	
	
	
<script>	
	function wonComma(x) {
		  x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
		  x = x.replace(/,/g,'');          // ,값 공백처리
		  $("#marketPrice").val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ',')); // 정규식을 이용해서 3자리 마다 , 추가 
		}		
</script>		
	
 
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
                   callbacks: {	//여기 부분이 이미지를 첨부하는 부분
                         onImageUpload : function(files) {
                             uploadSummernoteImageFile(files[0],this);
                         }
                     },
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
                url: "uploadSummernoteImageFile.bo",
                contentType: false,
                processData: false,
                enctype : 'multipart/form-data',
                success: function (data) {
                    //항상 업로드된 파일의 url이 있어야 한다.
                    $(editor).summernote('insertImage', data.url);
                }
            });
        }
		
    </script>



<!--**********************************
          Content body end
      ***********************************-->

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