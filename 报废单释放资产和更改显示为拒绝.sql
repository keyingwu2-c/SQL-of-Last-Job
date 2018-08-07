update dbo.AS_FAAssetScrapped set FStatus = 3 where FBizID='DFDA1B95-BE9E-4E02-9ADA-CC003D2AD475'
select * from AS_FAAssetScrapped where FBizID='EA5BAB54-64E5-4D45-BD75-A560BC069A76'
select * from AS_FAAssetScrapped where FBillNo='AS17030200003'



select * from AS_AssetCard  where  
      FAssetNumber in(select FAssetNumber from dbo.AS_FATempAssetMulAlter where FBizID='64716DEE-419B-4A57-A164-D01092DD40DA')  



update dbo.AS_AssetCard set FStatusID=3  
      where  
      FAssetNumber in(select FAssetNumber from dbo.AS_FATempAssetMulAlter where FBizID='DFDA1B95-BE9E-4E02-9ADA-CC003D2AD475')  